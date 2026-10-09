# frozen_string_literal: true

module Aigency
  module Tempdir
    class Write < Tool
      desc "Write a file in the temp directory"

      def execute(filename:, content:)
        aigent.log.puts "[Tempdir::Write] #{filename}"
        absolute_path = File.join(PATH, filename)
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
