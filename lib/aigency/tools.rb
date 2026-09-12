# frozen_string_literal: true

module Aigency
  module Tools
    # @return [Array<Class<Tool>>]
    def self.registry
      @registry ||= []
    end

    # @return [Hash{String => String}]
    def self.config_map
      @configs ||= {}
    end

    # @return [Array<String>]
    def self.directories
      @directories ||= []
    end

    # Register a tool.
    #
    # @param klass [Class<Tool>]
    # @return [void]
    def self.register klass
      registry.push klass
    end

    # Define a default configuration.
    #
    # @param name [String] The name of the config section
    # @param text [String] YAML-formatted config data
    # @return [void]
    def self.configure name, text
      config_map[name] = text
    end

    # Define directories to be created relative to an aigent's root.
    #
    def self.mkdir_p *paths
      directories.concat paths
    end
  end

  Tools.configure 'aigent', <<~EOF
    name: an Aigent
    openai_api_base: https://api.openai.com/v1
    openai_api_key: CHANGE_ME
    require:
      - aigency/email
      - aigency/wikipedia
      - aigency/workspace
  EOF

  Tools.mkdir_p 'data/chats', 'data/log'
end
