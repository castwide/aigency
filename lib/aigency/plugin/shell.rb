# frozen_string_literal: true

require 'thor'

module Aigency
  class Plugin
    class Shell < Thor
      include Delegator
    end
  end
end
