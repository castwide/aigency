# frozen_string_literal: true

require 'open3'

module Aigency
  module Homedir
    class Write < Tool
      include Helpers

      desc 'Write a file in the homedir'

      def execute(filename:, content:, append: true)
        resolved = expand_in_homedir(filename)
        write_mode = if append
          "a"
        else
          "w"
        end
        File.write resolved, content, mode: "#{write_mode}b"
        { success: true, filename: filename }
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}" }
      end

      private
    end
  end
end
