# frozen_string_literal: true

require 'fileutils'

module Aigency
  module Workspace
    class FileWriter < Tool
      include Helpers

      desc "Write a file to your private workspace"

      def execute(filename:, content:)
        aigent.log.puts "[Workspace::FileWriter] Writing #{filename}"

        resolved = expand_to_workspace(filename)
        FileUtils.mkdir_p File.dirname(resolved)
        File.write resolved, content, binmode: true
        { filename: filename, success: true }
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}" }
      end
    end
  end
end

Aigency::Tools.register Aigency::Workspace::FileWriter
