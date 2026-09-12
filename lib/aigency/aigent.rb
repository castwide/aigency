# frozen_string_literal: true

require 'fileutils'
require 'yaml'

module Aigency
  class Aigent
    # @return [IO]
    attr_reader :log

    def initialize(directory)
      @base_directory = File.absolute_path(directory)
      @log = $stdout
      load_requires
    end

    # @return [String]
    def name
      @name ||= config('aigent')['name'] || "an Aigent"
    end

    # Get the aigent directory with optional additional paths.
    #
    # @param paths [Array<String>] Additional paths
    # @return [String] The complete path
    def directory(*paths)
      File.join(@base_directory, *paths)
    end

    # Get the aigent data directory with optional additional paths.
    #
    # @param paths [Array<String>] Additional paths
    # @return [String] The complete path
    def data(*paths)
      directory('data', *paths)
    end

    # Initialize a RubyLLM::Chat.
    #
    # @param extra [Array<String>] Additional instructions
    # @return [RubyLLM::Chat]
    def brief(*extra)
      chat = rubyllm_context.chat(provider: :openai)
      Tools.registry.each { |klass| chat.with_tool(klass.new(self)) }
      chat.with_instructions(build_instructions(extra), append: true)
      # @todo This should be configurable
      chat.with_params(max_tokens: max_tokens)
    end

    def load filename, *extra, out: $stdout
      stream File.read(filename), *extra, out: out
    end

    def stream text, *extra, with: [], out: $stdout
      original_log = @log
      @log = out
      brief(*extra).ask text, with: with do |chunk|
        @log.print chunk.thinking&.text
        @log.print chunk.content
      end.tap { @log = original_log }
    end

    # @param name [String]
    # @return [Hash]
    def config(name)
      configs[name] ||= read_config(name)
    end

    # Initialize the aigent's tool configurations.
    #
    # @param only [Array<String>] Limit the tools being configured
    # @param overwrite [Boolean] Replace existing configs if true
    def setup(only: [], overwrite: false)
      only = [only].flatten.compact
      config_count = 0
      Tools.config_map.each do |name, text|
        next unless only.empty? || only.include?(name)

        dir = directory('config')
        FileUtils.mkdir_p dir
        path = File.join(dir, "#{name}.yml")
        if overwrite || !File.file?(path)
          doing = File.file?(path) ?  'Overwriting' : 'Writing new'
          log.puts "#{doing} config for #{name}"
          File.write path, text
          config_count += 1
        else
          log.puts "Config for #{name} exists, skipping"
        end
      end
      dir_count = 0
      Tools.directories.each do |path|
        absolute = directory(path)
        next if File.directory?(absolute)

        FileUtils.mkdir_p absolute
        dir_count += 1
      end
      log.puts "#{config_count} config files initialized."
      log.puts "#{dir_count} directories created."
    end

    # Run code in an exclusive lock
    #
    def lock(&block)
      File.open(data('lock'), 'w') do |file|
        file.flock(File::LOCK_EX)
        file.write(Process.pid)
        file.flush
        block&.call
      end
    end

    # Run code if an exclusive lock is available or skip if a lock exists
    #
    def try_with_lock(&block)
      File.open(data('lock'), 'w') do |file|
        acquired = file.flock(File::LOCK_EX|File::LOCK_NB)
        return unless acquired
        file.write(Process.pid)
        file.flush
        block&.call
      end
    end
    alias nonblock try_with_lock

    # True if an exclusive lock exists
    #
    def locked?
      File.open(data('lock'), File::RDWR|File::CREAT) do |file|
        result = file.flock(File::LOCK_EX|File::LOCK_NB)
        return !result
      end
    end
    alias busy? locked?

    def instructions
      @instructions ||= build_instructions([])
    end

    private

    def configs
      @configs ||= {}
    end

    def read_config(name)
      base = directory('config')
      filename = if name =~ /(\.yaml|\.yml)$/
        name
      else
        "#{name}.yml"
      end
      full_path = File.join(directory, 'config', filename)
      if File.file?(full_path)
        YAML.load_file(full_path)
      else
        warn "Config name #{name} not found at #{full_path}"
        {}
      end
    end

    def identity_file
      @identity_file ||= File.join(directory, 'IDENTITY.md')
    end

    def identity_file?
      File.file?(identity_file)
    end

    def base_instructions
      @base_instructions ||= identity_file? ? File.read(identity_file) : "You are a helpful AI assistant."
    end

    def build_instructions(extra)
      [base_instructions].concat tool_prompts
                         .push "Today's date is #{DateTime.now.strftime('%B %e, %Y')}."
                         .concat extra
                         .join("\n\n")
    end

    def tool_prompts
      Tools.config_map
           .keys
           .map { |name| config(name)['prompt'] }
           .compact
    end

    def load_requires
      read_requires.each { |name| require name }
    end

    def read_requires
      config('aigent')['require'] || []
    end

    def max_tokens
      @max_tokens ||= (config('aigent')['max_tokens'] || -1).to_i
    end

    def rubyllm_context
      RubyLLM.context do |config|
        config.openai_api_base = config('aigent')['openai_api_base']
        config.openai_api_key = config('aigent')['openai_api_key']
      end
    end
  end
end
