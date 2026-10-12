# frozen_string_literal: true

module Aigency
  # Commands that can be executed in aigent directories.
  #
  class Runner < Thor
    desc "say PROMPT", "Send a prompt to the aigent"
    def say(prompt)
      aigent.stream prompt
    end

    desc "load FILE", "Load a prompt from a file"
    def load(file)
      aigent.load filename
    end

    desc "setup", "Initialize aigent plugins"
    def setup
      aigent.setup
    end

    private

    def aigent
      @aigent ||= Aigency::Aigent.new('.')
    end
  end
end
