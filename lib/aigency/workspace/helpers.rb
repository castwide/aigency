# frozen_string_literal: true

module Aigency
  module Workspace
    module Helpers
      module_function

      # @!method aigent
      #   @abstract
      #   @return [Aigency::Aigent]

      # Expand a path relative to the aigent's workspace.
      #
      # @raise [PathError] if the expanded path is not inside the workspace
      # @param path [String]
      # @return [String]
      def expand_in_workspace(path)
        workspace = aigent.data('workspace')
        resolved = File.expand_path(path, workspace)
        return resolved if resolved == workspace || resolved.start_with?("#{workspace}/")
        raise PathError, "Permission denied: `#{path}` is not relative to your workspace"
      end

      # @raise [PathError] if the expanded path is not inside the workspace
      # @param arguments [Array<String>]
      # @param start [Integer]
      # @return [void]
      def validate_path_arguments(arguments, start = 0)
        current = 0
        glued_shorts = arguments.select { |arg| arg =~ /^-[^\-].+/ }
        unless glued_shorts.empty?
          raise PathError, "Permission denied: glued short options (#{glued_shorts.inspect}) are not allowed"
        end
        workspace = aigent.data('workspace')
        path_arguments(arguments).each do |arg|
          if !arg.start_with?('-')
            current += 1
            next unless current > start
          end
          path = split_path_part(arg)
          resolved = File.expand_path(path, workspace)
          next if resolved == workspace || resolved.start_with?("#{workspace}/")
          raise PathError, "Permission denied: `#{path}` is not relative to your workspace"
        end
      end

      def path_arguments(arguments)
        arguments.reject { |arg| arg =~ /^-[^\-]$/ || (arg.start_with?('--') && !arg.include?('=')) }
      end

      def split_path_part argument
        return argument unless argument.start_with?('-')
        if argument.start_with?('--')
          argument.split('=', 2).last
        else
          argument[2..]
        end
      end
    end
  end
end
