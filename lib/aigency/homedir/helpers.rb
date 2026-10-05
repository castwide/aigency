# frozen_string_literal: true

module Aigency
  module Homedir
    module Helpers
      module_function

      # @!method aigent
      #   @abstract
      #   @return [Aigency::Aigent]

      # Expand a path relative to the aigent's homedir.
      #
      # @raise [PathError] if the expanded path is not inside the homedir
      # @param path [String]
      # @return [String]
      def expand_in_homedir(path)
        homedir = aigent.data('homedir')
        resolved = File.expand_path(path, homedir)
        resolved = File.realpath(resolved) if File.symlink?(resolved)
        return resolved if resolved == homedir || resolved.start_with?("#{homedir}/")
        raise PathError, "Permission denied: `#{path}` is not relative to your homedir"
      end

      # @raise [PathError] if the expanded path is not inside the homedir
      # @param arguments [Array<String>]
      # @param start [Integer]
      # @return [void]
      def validate_path_arguments(arguments, start = 0)
        current = 0
        glued_shorts = arguments.select { |arg| arg =~ /^-[^\-].+/ }
        unless glued_shorts.empty?
          raise PathError, "Permission denied: glued short options (#{glued_shorts.inspect}) are not allowed"
        end
        homedir = aigent.data('homedir')
        path_arguments(arguments).each do |arg|
          if !arg.start_with?('-')
            current += 1
            next unless current > start
          end
          path = split_path_part(arg)
          resolved = File.expand_path(path, homedir)
          resolved = File.realpath(resolved) if File.symlink?(resolved)
          next if resolved == homedir || resolved.start_with?("#{homedir}/")
          raise PathError, "Permission denied: `#{path}` is not relative to your homedir"
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
