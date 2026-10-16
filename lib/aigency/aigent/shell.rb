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

      desc "instructions", "List all instructions given to the aigent before the user prompt"
      def instructions
        puts aigent.instructions
      end

      desc "stream", "Tail the currently active chat stream"
      option :follow, type: :boolean, aliases: :f, desc: "Follow the stream (tail -f)"
      option :lines, type: :numeric, aliases: :n, desc: "Number of lines (tail -n)", default: 10
      def stream
        if aigent.busy?
          file = Dir.glob(aigent.data('chats', '*.txt')).max { |file| File.mtime(file).to_i }
          cmd = ['tail', file, '-n', options[:lines].to_s]
          cmd.push '-f' if options[:follow]
          system *cmd
        else
          puts "No active chat stream."
        end
      end

      private

      def aigent
        @aigent ||= Aigency::Aigent.new('.')
      end
    end
  end
end
