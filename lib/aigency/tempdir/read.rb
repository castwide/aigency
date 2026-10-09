# frozen_string_literal: true

module Aigency
  module Tempdir
    class Read < Tool
      include Helpers

      desc "Read a file in the temp directory"

      def execute(filename:)
        aigent.log.puts "[Tempdir::Read] #{filename}"
        absolute_path = expand_in_tempdir(filename)
        {
          success: true,
          absolute_path: absolute_path,
          content: File.read(File.join(PATH, filename))
        }
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}"}
      end
    end
  end
end
