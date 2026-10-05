# frozen_string_literal: true

require 'open3'

module Aigency
  module Homedir
    class Shell < Tool
      include Helpers

      # @abstract
      # @return [String]
      def command
        raise 'Not implemented'
      end

      def first_path_argument = 0

      def execute(directory: '.', arguments: [])
        resolved = expand_in_homedir(directory)
        validate_path_arguments(arguments, first_path_argument)
        output, error, result = Open3.capture3(command, *arguments, chdir: resolved)
        { success: result.success?, stdout: output, stderr: error }
      rescue StandardError => e
        puts e.backtrace
        { success: false, error: "[#{e.class}] #{e.message}" }
      end

      private
    end
  end
end
