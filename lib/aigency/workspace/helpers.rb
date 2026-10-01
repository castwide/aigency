# frozen_string_literal: true

module Aigency
  module Workspace
    module Helpers
      # @!method aigent
      #   @abstract
      #   @return [Aigency::Aigent]

      # Expand a path relative to the aigent's workspace directory.
      #
      # @raise [PathError] if the expanded path is not inside the workspace
      # @param path [String]
      # @return [String]
      def expand_to_workspace(path)
        workspace = aigent.data('workspace')
        resolved = File.expand_path(path, workspace)
        return resolved if resolved == workspace || resolved.start_with?("#{workspace}/")

        raise PathError, "Permission denied: `#{path}` is not relative to your root workspace"
      end
    end
  end
end
