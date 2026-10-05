# frozen_string_literal: true

require 'open3'

module Aigency
  module Docker
    module Compose
      class Run < Aigency::Tool
        desc 'Run a shell command in your sandbox'

        params do
          string :command, description: "The complete command to execute", required: true
        end

        def execute(command:)
          aigent.log.puts "[Docker::Compose::Run] #{command}"
          output, error, result = Open3.capture3('docker', 'compose', 'run', '--quiet-build', 'app', command, chdir: aigent.directory)
          { success: result.success?, stdout: output, stderr: error }
        end
      end

      Tools.register Run
    end
  end
end
