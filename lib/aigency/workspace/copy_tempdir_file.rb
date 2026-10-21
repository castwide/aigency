# frozen_string_literal: true

require 'fileutils'

module Aigency
  module Workspace
    class CopyTempdirFile < Tool
      include Tempdir::Helpers
      include Workspace::Helpers

      description 'Copy a file from tempdir to workspace'

      parameters do
        string :tempdir_source, description: "A source filename in tempdir", required: true
        string :workspace_dest, description: "A destination filename in workspace", required: true
      end

      def execute(tempdir_source:, workspace_dest:)
        aigent.log.puts "[Workspace::CopyTempdirFile] #{tempdir_source.inspect} #{workspace_dest.inspect}"
        abs_tempdir = expand_in_tempdir(tempdir_source)
        abs_workspace = expand_in_workspace(workspace_dest)
        FileUtils.copy_file abs_tempdir, abs_workspace
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}"}
      end
    end
  end
end
