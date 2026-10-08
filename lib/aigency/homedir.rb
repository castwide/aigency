# frozen_string_literal: true

module Aigency
  module Homedir
    class PathError < ArgumentError; end

    require 'aigency/homedir/helpers'
    require 'aigency/homedir/shell'
    require 'aigency/homedir/cat'
    require 'aigency/homedir/cp'
    require 'aigency/homedir/diff'
    require 'aigency/homedir/grep'
    require 'aigency/homedir/ls'
    require 'aigency/homedir/mkdir'
    require 'aigency/homedir/mv'
    require 'aigency/homedir/rm'
    require 'aigency/homedir/wc'
    require 'aigency/homedir/write'

    Tools.mkdir_p 'data/homedir'

    Plugin.register Plugin.new(
      'homedir',
      directories: ['data/homedir'],
      tools: [Cat, Cp, Diff, Grep, Ls, Mkdir, Mv, Rm, Wc, Write]
    )
  end
end
