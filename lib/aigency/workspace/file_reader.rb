# frozen_string_literal: true

module Aigency
  module Workspace
    class FileReader < Tool
      include Helpers

      desc "Read a file from your private workspace"

      def execute(filename:)
        aigent.log.puts "[Workspace::FileReader] Reading #{filename}"

        resolved = expand_to_workspace(filename)

        {
          success: true,
          filename: filename,
          content: File.read(resolved, binmode: true)
        }
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}"}
      end
    end
  end
end

Aigency::Tools.register Aigency::Workspace::FileReader
