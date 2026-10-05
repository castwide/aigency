# frozen_string_literal: true

module Aigency
  module Homedir
    module Helpers
      module_function

      # @!method aigent
      #   @abstract
      #   @return [Aigency::Aigent]

      # Expand a path relative to the aigent's workspace directory.
      #
      # @raise [PathError] if the expanded path is not inside the workspace
      # @param path [String]
      # @return [String]
      def expand_in_homedir(path)
        homedir = aigent.data('homedir')
        resolved = File.expand_path(path, homedir)
        return resolved if resolved == homedir || resolved.start_with?("#{homedir}/")

        raise PathError, "Permission denied: `#{path}` is not relative to your homedir"
      end

      def validate_path_arguments(arguments, start = 0)
        homedir = aigent.data('homedir')
        path_arguments(arguments, start).each do |path|
          resolved = File.expand_path((path.start_with?('--') ? path.split('=', 2).last : path), homedir)
          next if resolved == homedir || resolved.start_with?("#{homedir}/")
          raise PathError, "Permission denied: `#{path}` is not relative to your homedir"
        end
      end

      # Select arguments that represent file or directory paths
      # Grep syntax: grep [options] pattern [file ...]
      # Arguments starting with '-' are options or option arguments
      # After options, the first argument is the pattern, remaining are paths
      def path_arguments(arguments, start = 0)
        arguments.reject { |arg| arg.start_with?(/-[^\-]/) || (arg.start_with?('--') && !arg.include?('=')) }
                 .[](start..) || []
      end
    end
  end
end
