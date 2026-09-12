# frozen_string_literal: true

module Aigency
  module Workspace
    class DirectoryDeleter < Tool
      desc "Deletes a directory from your private workspace"

      def execute(dirname:)
        puts "Deleting directory #{dirname}"

        resolved = File.absolute_path(dirname, aigent.data('workspace'))
        return { dirname: dirname, success: false, error: "Permission denied" } unless resolved.start_with?(aigent.data('workspace'))
        return { dirname: dirname, success: false, error: "Permission denied" } if resolved.include?('/.git/') || resolved.end_with?('/.git')
        return { dirname: dirname, success: false, error: "Not a directory" } if File.file?(resolved)
        return { dirname: dirname, sucess: false, error: "Directory not found" } unless File.directory?(resolved)

        FileUtils.rm_rf(resolved)
        { dirname: dirname, success: true }
      end
    end
  end
end

Aigency::Tools.register Aigency::Workspace::DirectoryDeleter
