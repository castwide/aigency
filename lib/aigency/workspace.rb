# frozen_string_literal: true

module Aigency
  module Workspace
    require 'aigency/workspace/helpers'
    require 'aigency/workspace/directory_deleter'
    require 'aigency/workspace/directory_reader'
    require 'aigency/workspace/file_reader'
    require 'aigency/workspace/file_writer'

    class PathError < RuntimeError; end
  end

  Tools.mkdir_p 'data/workspace'
end
