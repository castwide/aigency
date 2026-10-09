# frozen_string_literal: true

module Aigency
  module Sandbox
    require 'aigency/sandbox/exec'

    Plugin.register Plugin.new(
      'sandbox',
      tools: [Sandbox::Exec],
      directories: ['data/sandbox', 'data/sandbox_ssh'],
      files: {
        'Dockerfile' => File.read(File.join(GEM_PATH, 'scaffold', 'sandbox', 'Dockerfile')),
        'docker-compose.yml' => File.read(File.join(GEM_PATH, 'scaffold', 'sandbox', 'docker-compose')),
        'squid.conf' => File.read(File.join(GEM_PATH, 'scaffold', 'sandbox', 'squid.conf')),
        'data/sandbox_ssh/config' => File.read(File.join(GEM_PATH, 'scaffold', 'sandbox', 'ssh_config'))
      },
      config: <<~FILE
        prompt: "The sandbox tools provide access to a Docker container."
      FILE
    )
  end
end
