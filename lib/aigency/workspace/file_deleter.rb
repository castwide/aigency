# frozen_string_literal: true

module Aigency
  module Workspace
    class FileDeleter < Tool
      include Helpers

      desc "Delete a file from your private workspace"

      def execute(filename:)
        aigent.log.puts "[Workspace::FileDeleter] Deleting file #{filename}"
        resolved = expand_to_workspace(filename)
        File.delete resolved
        { filename: filename, success: true }
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}" }
      end
    end
  end
end

Aigency::Tools.register Aigency::Workspace::FileDeleter
