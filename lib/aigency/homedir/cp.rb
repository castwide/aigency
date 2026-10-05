# frozen_string_literal: true

module Aigency
  module Homedir
    class Cp < Shell
      desc 'Run the `cp` shell command in your homedir'

      def command = 'cp'
    end

    Tools.register Cp
  end
end
