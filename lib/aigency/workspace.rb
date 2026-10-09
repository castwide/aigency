# frozen_string_literal: true

module Aigency
  module Workspace
    require 'aigency/workspace/helpers'
    require 'aigency/workspace/shell'
    require 'aigency/workspace/cat'
    require 'aigency/workspace/cp'
    require 'aigency/workspace/diff'
    require 'aigency/workspace/grep'
    require 'aigency/workspace/ls'
    require 'aigency/workspace/mkdir'
    require 'aigency/workspace/mv'
    require 'aigency/workspace/rm'
    require 'aigency/workspace/wc'
    require 'aigency/workspace/write'

    Plugin.register Plugin.new(
      'workspace',
      directories: ['data/workspace'],
      tools: [Cat, Cp, Diff, Grep, Ls, Mkdir, Mv, Rm, Wc, Write],
      config: <<~FILE
        prompt: "The workspace tools provide access to a readable and writeable directory."
      FILE
    )
  end
end
