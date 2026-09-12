# frozen_string_literal: true

module Aigency
  module Workspace
    require 'aigency/workspace/directory_reader'
    require 'aigency/workspace/file_reader'
    require 'aigency/workspace/file_writer'
  end

  Tools.mkdir_p 'data/workspace'
end
