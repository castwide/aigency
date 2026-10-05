# frozen_string_literal: true

module Aigency
  module Homedir
    class Mv < Shell
      desc 'Run the `mv` shell command in your homedir'

      def command = 'mv'
    end

    Tools.register Mv
  end
end
