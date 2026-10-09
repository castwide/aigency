# frozen_string_literal: true

require 'ruby_llm'

# Core
require 'aigency/version'
require 'aigency/usability'
require 'aigency/tool'
require 'aigency/aigent'
require 'aigency/plugin'
require 'aigency/shell'

# Extensions
require 'aigency/workspace'
require 'aigency/sandbox'

module Aigency
  GEM_PATH = File.absolute_path(File.join(__dir__, '..'))

  class Error < StandardError; end
  # Your code goes here...
end
