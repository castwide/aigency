# frozen_string_literal: true

require 'date'

module Aigency
  class Aigent
    class CurrentTime < Aigency::Tool
      desc 'Get the current time'

      params do
        any_of :format, description: "Date/time format" do
          string enum: %w[iso8601 unix]
          'iso8601'
        end
      end

      def execute(format: 'iso8601')
        aigent.log.puts "[Aigent::CurrentTime] #{format}"
        now = DateTime.now
        case format
        when 'iso8601'
          { success: true, current_time: now.iso8601 }
        when 'unix'
          { success: true, current_time: now.to_time.to_i }
        else
          { success: false, error: "Invalid format: #{format}" }
        end
      rescue StandardError => e
        { success: false, error: "[#{e.class}] #{e.message}"}
      end
    end
  end
end
