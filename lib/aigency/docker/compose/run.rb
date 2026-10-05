# frozen_string_literal: true

require 'open3'

module Aigency
  module Docker
    module Compose
      class Run < Tool
        desc 'Run a shell command in your sandbox'

        def execute(command:)
          aigent.log.puts "[Docker::Compose::Run] #{command}"
          output, error, result = Open3.capture3(['docker', 'compose', 'run', 'app', command], chdir: aigent.directory)
          { success: result.success?, stdout: output, stderr: error }
        end
      end
    end
  end
end
