# frozen_string_literal: true

module Aigency
  module Workspace
    class DirectoryReader < Tool
      include Helpers

      desc "Get the contents of a directory from your private workspace"

      def execute(directory_name:)
        aigent.log.puts "[Workspace::DirectoryReader] Reading #{directory_name}"
        resolved = expand_to_workspace(directory_name)
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
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}" }
      end
    end
  end
end

Aigency::Tools.register Aigency::Workspace::DirectoryReader
