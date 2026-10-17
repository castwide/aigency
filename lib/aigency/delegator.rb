# frozen_string_literal: true

module Aigency
  module Delegator
    module_function

    def aigent
      @aigent ||= Aigent.new(Dir.pwd)
    end
  end
end
