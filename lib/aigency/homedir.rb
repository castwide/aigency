# frozen_string_literal: true

module Aigency
  module Homedir
    class PathError < ArgumentError; end

    require 'aigency/homedir/helpers'
    require 'aigency/homedir/shell'
    require 'aigency/homedir/ls'

    Tools.mkdir_p 'data/workspace'
  end
end
