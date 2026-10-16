# frozen_string_literal: true

require 'fileutils'
require 'yaml'
require 'set'

module Aigency
  class Aigent
    require 'aigency/aigent/current_time'
    require 'aigency/aigent/shell'

    # @return [IO]
    attr_reader :log

    def initialize(directory)
      @base_directory = File.absolute_path(directory)
      @log = $stdout
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
    # @param except [Array<Class<Tool>>] Tools to exclude from this chat
    # @return [RubyLLM::Chat]
    def brief(*extra, except: [])
      chat = rubyllm_context.chat(provider: :openai)
      (tools - except).each { |klass| chat.with_tool(klass.new(self)) }
      chat.with_instructions(build_instructions(extra), append: true)
      chat.with_params(max_tokens: max_tokens)
    end

    # Prompt a chat with a file.
    #
    # @param filename [String]
    # @param extra [Array<String>] Additional instructions
    # @param except [Array<Class<Tool>>] Tools to exclude from this chat
    # @param out [IO]
    # @return [RubyLLM::Chat]
    def load filename, *extra, except: [], out: $stdout
      stream File.read(filename), *extra, except: except, out: out
    end

    # Prompt a chat.
    #
    # @param text [String]
    # @param extra [Array<String>] Additional instructions
    # @param except [Array<Class<Tool>>] Tools to exclude from this chat
    # @param out [IO]
    # @return [RubyLLM::Chat]
    def stream text, *extra, attach: [], except: [], out: $stdout
      original_log = @log
      @log = out
      response = brief(*extra, except: except).ask text, with: attach do |chunk|
        @log.print chunk.thinking&.text
        @log.print chunk.content
      end
      @log.puts "Input tokens:    #{response.tokens.input}"
      @log.puts "Output tokens:   #{response.tokens.output}"
      response
    rescue StandardError => e
      @log.puts "[#{e.class}] #{e.message}"
      @log.puts e.backtrace
    ensure
      @log = original_log
    end

    # @param name [String]
    # @return [Hash]
    def config(name)
      configs[name] ||= read_config(name)
    end

    # Initialize the aigent's plugin configurations.
    #
    # @return [void]
    def setup
      plugins.each { |plugin| boot plugin }
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

    # @return [String]
    def instructions
      @instructions ||= build_instructions([]).join("\n\n")
    end

    # @return [Array<Plugin>]
    def plugins
      config('aigent').fetch('plugins', [])
                      .unshift('aigent')
                      .uniq
                      .map { |name| Plugin.registry[name] }
    end

    def tools
      plugins.flat_map(&:tools).uniq
    end

    private

    # @param plugin [Plugin]
    def boot(plugin)
      unless plugin.config.empty?
        config_file = File.absolute_path(File.join('config', "#{plugin.name}.yml"), directory)
        if File.exist?(config_file)
          log.puts "File config/#{plugin.name}.yml exists, skipping"
        else
          log.puts "Creating config/#{plugin.name}.yml"
          File.write config_file, plugin.config
        end
      end
      plugin.directories.each do |dir|
        absolute = File.absolute_path(dir, directory)
        if File.directory?(absolute)
          log.puts "Directory #{dir} exists, skipping"
        else
          log.puts "Creating #{dir}"
          FileUtils.mkdir_p absolute
        end
      end
      plugin.files.each do |file, content|
        absolute = File.absolute_path(file, directory)
        if File.exist?(absolute)
          log.puts "File #{file} exists, skipping"
        else
          log.puts "Creating #{file}"
          File.write absolute, content
        end
      end
    end

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
        content = File.read(full_path)
                      .gsub(/\${([^}]+)}/) { ENV.fetch($1) }
        YAML.load(content)
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
                         .concat extra
                         .join("\n\n")
    end

    def tool_prompts
      # @todo Should aigents load prompts from config files that do not have
      #   a corresponding plugin?
      plugins.map { |plugin| config(plugin.name)['prompt'] }
             .compact
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

    Plugin.register Plugin.new(
      'aigent',
      tools: [CurrentTime],
      directories: ['data/chats', 'data/log'],
      rakefile: File.join(GEM_PATH, 'scaffold', 'aigent', 'aigent.rake')
    )
  end
end
