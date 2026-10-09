# frozen_string_literal: true

module Aigency
  module Sandbox
    require 'aigency/sandbox/exec'

    Plugin.register Plugin.new(
      'sandbox',
      tools: [Sandbox::Exec],
      directories: ['data/sandbox']
    )
  end
end
