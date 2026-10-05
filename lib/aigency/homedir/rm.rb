# frozen_string_literal: true

module Aigency
  module Homedir
    class Rm < Shell
      desc 'Run the `rm` shell command in your homedir'

      def command = 'rm'
    end

    Tools.register Rm
  end
end
