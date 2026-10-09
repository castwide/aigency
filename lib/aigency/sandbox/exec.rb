# frozen_string_literal: true

require 'open3'

module Aigency
  module Sandbox
    class Exec < Aigency::Tool
      desc 'Run a shell command in your sandbox'

      params do
        string :command, description: "The complete command to execute", required: true
      end

      def execute(command:)
        aigent.log.puts "[Docker::Compose::Exec] #{command}"
        output, error, result = Open3.capture3('docker', 'compose', 'exec', '--quiet-build', 'app', 'sh', '-c', command, chdir: aigent.directory)
        { success: result.success?, stdout: output, stderr: error }
      end
    end
  end
end
