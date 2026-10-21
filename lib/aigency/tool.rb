# frozen_string_literal: true

module Aigency
  # A subclass of RubyLLM::Tool with aigent integration.
  #
  class Tool < RubyLLM::Tool
    include Usability

    class << self
      alias desc description
      alias params parameters
    end
  end
end
