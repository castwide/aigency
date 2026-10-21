# frozen_string_literal: true

module Aigency
  module Tempdir
    class Write < Tool
      include Helpers

      description "Write a file in the temp directory"

      parameters do
        string :filename, description: "The filename to write"
        string :content, description: "The file's content"
      end

      def execute(filename:, content:)
        aigent.log.puts "[Tempdir::Write] #{filename}"
        absolute_path = expand_in_tempdir(filename)
        File.write absolute_path, content
        {
          success: true,
          absolute_path: absolute_path
        }
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}"}
      end
    end
  end
end
