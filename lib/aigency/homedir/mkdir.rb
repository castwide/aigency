# frozen_string_literal: true

module Aigency
  module Homedir
    class Mkdir < Shell
      desc 'Run the `mkdir` shell command in your homedir'

      def command = 'mkdir'
    end

    Tools.register Mkdir
  end
end
