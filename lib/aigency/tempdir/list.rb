# frozen_string_literal: true

module Aigency
  module Tempdir
    class List < Tool
      description "List all files in the temp directory"

      def execute
        aigent.log.puts "[Tempdir::List]"
        {
          success: true,
          absolute_paths: Dir.glob(File.join(PATH, '**', '*'))
        }
      end
    end
  end
end
