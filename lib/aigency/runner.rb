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
      aigent.nonblock do
        filename = File.join('data', 'chats', "#{Time.now.strftime("%Y-%m-%d_%H%M%S")}_load_#{file.gsub('/', '_')}.txt")
        File.open(filename, 'w') do |file|
          aigent.load args[:filename], out: file
        rescue StandardError => e
          file.puts "[#{e.class}]: #{e.message}"
          file.puts e.backtrace
        end
      end
    end

    def setup
      aigent.setup
    end

    private

    def aigent
      @aigent ||= Aigency::Aigent.new('.')
    end
  end
end
