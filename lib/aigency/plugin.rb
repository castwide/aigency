# frozen_string_literal: true

module Aigency
  class Plugin
    require 'aigency/plugin/shell'

    attr_reader :name, :config, :tools, :directories, :files, :rakefile, :shell

    # @param name [String]
    # @param tools [Array<Class<Tool>>]
    # @param config [String]
    # @param directories [Array<String>]
    # @param files [Hash{String => String}]
    def initialize name, tools: [], config: '', directories: [], files: {}, rakefile: nil, shell: nil
      raise "A plugin named '#{name}' already exists" if self.class.registry.key?(name)
      @name = name
      @config = config
      @tools = tools
      @directories = directories
      @files = files
      @rakefile = rakefile
      @shell = shell
      self.class.registry[name] = self
    end

    def self.registry
      @registry ||= {}
    end

    # @param plugin [Plugin]
    def self.register plugin
      registry[plugin.name] = plugin
    end

    def self.create(...)
      register new(...)
    end
  end
end
