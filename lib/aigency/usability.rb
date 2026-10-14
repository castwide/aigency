# frozen_string_literal: true

module Aigency
  module Usability
    # @return [Aigent]
    attr_reader :aigent

    def initialize(aigent)
      @aigent = aigent
      post_initialize
    end

    def post_initialize
    end

    # Subclasses need to implement functionality here.
    #
    # @abstract
    def execute(**opts)
      raise 'Not implemented'
    end

    def self.included other
      other.extend ClassMethods
    end

    module ClassMethods
      def execute(aigent, **opts)
        new(aigent).execute(**opts)
      end
    end
  end
end
