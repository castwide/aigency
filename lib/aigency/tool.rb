# frozen_string_literal: true

module Aigency
  # A subclass of RubyLLM::Tool with aigent integration.
  #
  class Tool < RubyLLM::Tool
    include Usability
  end
end
