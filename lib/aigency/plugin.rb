# frozen_string_literal: true

module Aigency
  class Plugin
    attr_reader :name, :config, :tools, :directories, :files

    # @param name [String]
    # @param tools [Array<Class<Tool>>]
    # @param config [String]
    # @param directories [Array<String>]
    # @param files [Hash{String => String}]
    def initialize name, tools: [], config: '', directories: [], files: {}
      raise "A plugin named '#{name}' already exists" if self.class.registry.key?(name)
      @name = name
      @config = config
      @tools = tools
      @directories = directories
      @files = files
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
