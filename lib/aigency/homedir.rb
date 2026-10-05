# frozen_string_literal: true

module Aigency
  module Homedir
    class PathError < ArgumentError; end

    require 'aigency/homedir/helpers'
    require 'aigency/homedir/shell'
    require 'aigency/homedir/cp'
    require 'aigency/homedir/ls'
    require 'aigency/homedir/rm'

    Tools.mkdir_p 'data/workspace'
  end
end
