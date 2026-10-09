# frozen_string_literal: true

module Aigency
  module Sandbox
    require 'aigency/sandbox/exec'

    Plugin.register Plugin.new(
      'sandbox',
      tools: [Sandbox::Exec],
      directories: ['data/sandbox', 'data/sandbox_ssh'],
      files: {
        'Dockerfile' => File.read(File.join(__dir__, 'sandbox', 'Dockerfile.tpl')),
        'docker-compose.yml' => File.read(File.join(__dir__, 'sandbox', 'docker-compose.yml.tpl')),
        'squid.conf' => File.read(File.join(__dir__, 'sandbox', 'squid.conf.tpl'))
      }
    )
  end
end
