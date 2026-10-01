# frozen_string_literal: true

module Aigency
  module Workspace
    class DirectoryReader < Tool
      desc "Gets the contents of a directory from your private workspace"

      def execute(directory_name:)
        aigent.log.puts "[Workspace::DirectoryReader] Reading #{directory_name}"
        directory = aigent.data('workspace')
        resolved = File.absolute_path(directory_name, directory)
        return { directory: directory_name,
                 success: false,
                 error: "Permission denied. Path must be local to #{directory}" } unless resolved.start_with?(directory)

        if File.directory?(resolved)
          {
            directory: directory_name,
            success: true,
            entries: Dir.entries(resolved)[2..]
          }
        else
          {
            directory: directory_name,
            success: false,
            error: "Not a directory"
          }
        end
      end
    end
  end
end

Aigency::Tools.register Aigency::Workspace::DirectoryReader
