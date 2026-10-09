# frozen_string_literal: true

module Aigency
  module Tempdir
    module Helpers
      module_function

      def expand_in_tempdir path
        absolute = File.absolute_path(path, PATH)
        raise PathError, "#{path} is not relative to tempdir" unless absolute.start_with?(PATH)
        absolute
      end
    end
  end
end
