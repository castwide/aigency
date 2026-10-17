# frozen_string_literal: true

require 'thor'

module Aigency
  class Aigent
    # Commands that can be executed in aigent directories.
    #
    class Shell < Thor
      include Delegator

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

      desc "instructions", "List base instructions"
      long_desc <<~DESC
        Show all instructions that will be given to the aigent before the user
        prompt. They typically include the IDENTITY.md file and any prompts injected
        by installed plugins.
      DESC
      def instructions
        puts aigent.instructions
      end

      desc "stream", "Tail the currently active chat stream"
      option :follow, type: :boolean, aliases: :f, desc: "Follow the stream (tail -f)"
      option :lines, type: :numeric, aliases: :n, desc: "Number of lines (tail -n)", default: 10
      long_desc <<~DESC
        This is useful for monitoring non-interactive chat streams, e.g., chat sessions
        that were started by cron jobs or rake tasks. It runs `tail` on the current chat
        file in the aigent's data/chats folder.
      DESC
      def stream
        if aigent.busy?
          file = Dir.glob(aigent.data('chats', '*.txt')).max { |file| File.mtime(file).to_i }
          cmd = ['tail', file, '-n', options[:lines].to_s]
          cmd.push '-f' if options[:follow]
          puts "(#{file})"
          system *cmd
        else
          puts "No active chat stream."
        end
      end

      def self.start(given_args = ARGV, config = {})
        @plugins ||= Delegator.aigent.plugins.map do |plugin|
          next unless plugin.shell
          if all_commands.key?(plugin.name)
            raise "Plugin '#{plugin.name}' cannot register CLI command '#{plugin.name}': already taken"
          end
          register(plugin.shell, plugin.name, "#{plugin.name} [SUBCOMMAND ...ARGS]", "#{plugin.name} plugin commands")
          plugin
        end
        super
      end
    end
  end
end
