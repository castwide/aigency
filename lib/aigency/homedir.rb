# frozen_string_literal: true

module Aigency
  module Homedir
    class PathError < ArgumentError; end

    require 'aigency/homedir/helpers'
    require 'aigency/homedir/shell'
    require 'aigency/homedir/cp'
    require 'aigency/homedir/ls'
    require 'aigency/homedir/mkdir'
    require 'aigency/homedir/rm'
    require 'aigency/homedir/write'

    Tools.mkdir_p 'data/workspace'
  end
end
