# frozen_string_literal: true

require 'thor'

module Aigency
  class Aigent
    # Commands that can be executed in aigent directories.
    #
    class Shell < Thor
      desc "say PROMPT", "Send a prompt to the aigent"
      def say(prompt)
        aigent.stream prompt
      end

      desc "load FILE", "Load a prompt from a file"
      def load(file)
        aigent.load filename
      end

      desc "setup", "Initialize aigent plugins"
      def setup
        aigent.setup
      end

      desc "tools", "Get a list of available tools"
      def tools
        puts aigent.tools.map(&:to_s).sort
      end

      desc "status", "Get the aigent's current status"
      def status
        puts "Busy: #{aigent.busy?}"
      end

      private

      def aigent
        @aigent ||= Aigency::Aigent.new('.')
      end
    end
  end
end
