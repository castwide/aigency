# frozen_string_literal: true

module Aigency
  module Docker
    require 'aigency/docker/compose'

    Plugin.register Plugin.new(
      'docker',
      tools: [Compose::Run],
      directories: 'data/homedir'
    )
  end
end
