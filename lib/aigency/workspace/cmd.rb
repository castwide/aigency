# frozen_string_literal: true

require 'open3'

module Aigency
  module Workspace
    class Cmd < Tool
      include Helpers

      # @abstract
      # @return [String]
      def command
        raise 'Not implemented'
      end

      def non_path_arguments = []

      def prohibited_arguments = []

      def execute(directory: '.', arguments: [])
        aigent.log.puts "[Workspace::Shell] #{command} #{arguments.inspect}"
        if any_prohibited?(arguments)
          return { success: false, error: "Permission denied: the following arguments to `#{command}` are prohibited: #{prohibited_arguments.inspect}" }
        end
        resolved = expand_in_workspace(directory)
        if arguments != ['--help'] && arguments[0, non_path_arguments.length].any? { |arg| arg.start_with?('-') }
          return { success: false, error: non_path_argument_error }
        end
        validate_path_arguments(arguments, non_path_arguments.length)
        output, error, result = Open3.capture3(command, *arguments, chdir: resolved)
        { success: result.success?, stdout: output, stderr: error }
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}" }
      end

      def self.inherited other
        other.params do
          string :directory, description: "The working directory relative to workspace", required: false
          array :arguments, of: :string, description: "Command arguments", required: false
        end
      end

      private

      def non_path_argument_error
        arg_count = if non_path_arguments.length > 1
          "#{non_path_arguments.length} arguments"
        else
          'argument'
        end
        "Permission denied: first #{arg_count} must be [#{non_path_arguments.join(', ')}] unless the only argument is `--help`"
      end

      def any_prohibited?(arguments)
        arguments.any? { |arg| arg.start_with?(*prohibited_arguments) }
      end
    end
  end
end
