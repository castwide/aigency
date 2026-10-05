# frozen_string_literal: true

module Aigency
  module Homedir
    class Grep < Shell
      desc 'Run the `grep` shell command in your homedir'

      def command = 'grep'

      def first_path_argument = 1

      def execute(directory: '.', arguments: [])
        if arguments.any? { |arg| arg.start_with?('-f') || arg.start_with?('--file') }
          return { success: false, error: 'Permission denied: -f and --file are prohibited arguments' }
        end
        super
      end
    end

    Tools.register Grep
  end
end
