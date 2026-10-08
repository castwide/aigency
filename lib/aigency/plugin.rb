# frozen_string_literal: true

module Aigency
  class Plugin
    attr_reader :name, :tools, :directories, :files, :plugins

    def initialize name, tools: [], directories: [], files: {}, plugins: []
      raise "A plugin named '#{name}' already exists" if self.class.registry.key?(name)
      @name = name
      @tools = tools
      @directories = directories
      @files = files
      @plugins = plugins
      self.class.registry[name] = self
    end

    def self.registry
      @registry ||= {}
    end

    # @param plugin [Plugin]
    def self.register plugin
      registry[plugin.name] = plugin
    end
  end
end
