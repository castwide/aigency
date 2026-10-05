# frozen_string_literal: true

require 'open3'

module Aigency
  module Homedir
    # @note Unlike most of the Homedir tools, this one does not execute a shell
    #   command. It uses ruby's File module instead.
    #
    class Write < Tool
      include Helpers

      desc 'Write or append to a file in the homedir'

      params do
        string :filename, description: "The filename relative to the homedir", required: true
        string :content, description: "The data to write to the file", required: true
        string :append, description: "Append if true or overwrite if false", default: true
      end

      def execute(filename:, content:, append: true)
        aigent.log.puts "[Homedir::Write] #{filename}"
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
    end

    Tools.register Write
  end
end
