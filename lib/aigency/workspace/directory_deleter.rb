# frozen_string_literal: true

module Aigency
  module Workspace
    class DirectoryDeleter < Tool
      include Helpers

      desc "Delete a directory and all of its contents from your private workspace"

      def execute(directory_name:)
        aigent.log.puts "[Workspace::DirectoryDeleter] #{directory_name}"

        resolved = expand_to_workspace(directory_name)
        FileUtils.rm_rf(resolved)
        { dirname: directory_name, success: true }
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}"}
      end
    end
  end
end

Aigency::Tools.register Aigency::Workspace::DirectoryDeleter
