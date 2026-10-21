# frozen_string_literal: true

module Aigency
  module Tempdir
    class Read < Tool
      include Helpers

      desc "Read a file in the temp directory"

      def execute(filename:)
        aigent.log.puts "[Tempdir::Read] #{filename}"
        absolute_path = expand_in_tempdir(filename)
        # @todo Hardcoded max size
        if File.size(absolute_path) > 500_000
          { success: false, error: "File is too large to read (max 500000 bytes)"}
        else
          {
            success: true,
            absolute_path: absolute_path,
            content: File.read(File.join(PATH, filename))
          }
        end
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}"}
      end
    end
  end
end
