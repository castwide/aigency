# frozen_string_literal: true

require 'fileutils'

module Aigency
  module Workspace
    class CopyTempdirFile < Tool
      desc 'Copy a file from tempdir to workspace'

      params do
        string :tempdir_source, description: "A source filename in tempdir", required: true
        string :workspace_dest, description: "A destination filename in workspace", required: true
      end

      def execute(tempdir_source:, workspace_dest:)
        abs_tempdir = Tempdir::Helpers.expand_in_tempdir(tempdir_source)
        abs_workspace = Workspace::Helpers.expand_in_workspace(workspace_dest)
        FileUtils.copy_file abs_tempdir, abs_workspace
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}"}
      end
    end
  end
end
