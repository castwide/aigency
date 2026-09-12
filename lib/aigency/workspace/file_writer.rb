# frozen_string_literal: true

require 'fileutils'

module Aigency
  module Workspace
    class FileWriter < Tool
      desc "Writes a file to your private workspace"

      def execute(filename:, content:)
        aigent.log.puts "[Workspace::FileWriter] Writing #{filename}"

        directory = aigent.data('workspace')
        resolved = File.absolute_path(filename, directory)
        return { filename: filename, success: false, error: "Permission denied" } unless resolved.start_with?(directory)

        FileUtils.mkdir_p File.dirname(resolved)
        File.write resolved, content
        return { filename: filename, success: true }
      end
    end
  end
end

Aigency::Tools.register Aigency::Workspace::FileWriter
