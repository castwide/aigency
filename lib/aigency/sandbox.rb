# frozen_string_literal: true

module Aigency
  module Sandbox
    require 'aigency/sandbox/exec'

    Plugin.register Plugin.new(
      'sandbox',
      tools: [Sandbox::Exec],
      directories: ['sandbox', 'data/sandbox', 'data/sandbox_ssh'],
      files: {
        'sandbox/Dockerfile' => File.read(File.join(GEM_PATH, 'scaffold', 'sandbox', 'Dockerfile')),
        'sandbox/squid.conf' => File.read(File.join(GEM_PATH, 'scaffold', 'sandbox', 'squid.conf')),
        'docker-compose.yml' => File.read(File.join(GEM_PATH, 'scaffold', 'sandbox', 'docker-compose.yml')),
        'data/sandbox_ssh/config' => File.read(File.join(GEM_PATH, 'scaffold', 'sandbox', 'ssh_config'))
      },
      config: <<~FILE
        prompt: "The sandbox tools provide access to a Docker container."
      FILE
    )
  end
end
