# frozen_string_literal: true

module Aigency
  module Homedir
    class Wc < Shell
      desc 'Run the `wc` shell command in your homedir'

      def command = 'wc'
    end
  end
end
