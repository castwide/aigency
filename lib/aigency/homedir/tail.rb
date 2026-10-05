# frozen_string_literal: true

module Aigency
  module Homedir
    class Tail < Shell
      desc 'Run the `tail` shell command in your homedir'

      def command = 'tail'
    end
  end
end
