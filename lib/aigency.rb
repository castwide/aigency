# frozen_string_literal: true

require 'ruby_llm'

module Aigency
  GEM_PATH = File.absolute_path(File.join(__dir__, '..'))

  # Core
  require 'aigency/version'
  require 'aigency/usability'
  require 'aigency/tool'
  require 'aigency/aigent'
  require 'aigency/plugin'
  require 'aigency/shell'

  # Plugins and Tools
  require 'aigency/sandbox'
  require 'aigency/tempdir'
  require 'aigency/workspace'
end
