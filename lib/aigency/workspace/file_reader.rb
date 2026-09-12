# frozen_string_literal: true

module Aigency
  module Workspace
    class FileReader < Tool
      desc "Reads a file from your private workspace"

      def execute(filename:)
        aigent.log.puts "[Workspace::FileReader] Reading #{filename}"

        directory = aigent.data('workspace')
        resolved = File.absolute_path(filename, directory)
        return { filename: filename, success: false, error: "Permission denied" } unless resolved.start_with?(directory)

        if File.file?(resolved)
          {
            filename: filename,
            success: true,
            content: File.read(resolved)
          }
        else
          {
            filename: filename,
            success: false,
            error: "File not found"
          }
        end
      end
    end
  end
end

Aigency::Tools.register Aigency::Workspace::FileReader
