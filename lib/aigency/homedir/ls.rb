# frozen_string_literal: true

module Aigency
  module Homedir
    class Ls < Shell
      desc 'Run the `ls` shell command in your homedir'

      def command = 'ls'
    end
  end
end
