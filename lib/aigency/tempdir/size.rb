# frozen_string_literal: true

module Aigency
  module Tempdir
    class Size < Tool
      include Helpers

      desc "Get the size of a file in the temp directory"

      def execute(filename:)
        aigent.log.puts "[Tempdir::Read] #{filename}"
        absolute_path = expand_in_tempdir(filename)
        {
          success: true,
          absolute_path: absolute_path,
          size: File.size(absolute_path)
        }
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}"}
      end
    end
  end
end
