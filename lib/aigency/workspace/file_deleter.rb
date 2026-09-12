# frozen_string_literal: true

module Aigency
  module Workspace
    class FileDeleter < Tool
      desc "Deletes a file from your private workspace"

      def execute(filename:)
        aigent.log.puts "[Workspace::FileDeleter] Deleting file #{filename}"

        directory = aigent.data('directory')
        resolved = File.absolute_path(filename, directory)
        return { filename: filename, error: "Permission denied" } unless resolved.start_with?(directory)
        return { filename: filename, error: "Permission denied" } if resolved.include?('/.git/')
        return { filename: filename, error: "File does not exist" } unless File.file?(resolved)

        File.delete resolved
        { filename: filename, success: true }
      end
    end
  end
end

Aigency::Tools.register Aigency::Workspace::FileDeleter
