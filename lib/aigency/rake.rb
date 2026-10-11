# frozen_string_literal: true

module Aigency
  module Rake
    def self.define(directory = '.')
      aigent = Aigent.new(directory)
      aigent.plugins
            .map(&:rakefile)
            .compact
            .each { |rakefile| ::Rake.load_rakefile(rakefile) }
    end
  end
end
