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
        aigent.log.puts "[Homedir::Shell] #{command} #{arguments.inspect}"
        resolved = expand_in_homedir(directory)
        validate_path_arguments(arguments, first_path_argument)
        output, error, result = Open3.capture3(command, *arguments, chdir: resolved)
        { success: result.success?, stdout: output, stderr: error }
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}" }
      end

      def self.inherited other
        other.params do
          string :directory, description: "The working directory relative to homedir", required: false
          array :arguments, of: :string, description: "Command arguments", required: false
        end
      end
    end
  end
end
