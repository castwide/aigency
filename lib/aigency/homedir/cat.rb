# frozen_string_literal: true

module Aigency
  module Homedir
    class Cat < Shell
      desc 'Run the `cat` shell command in your homedir'

      def command = 'cat'
    end

    Tools.register Cat
  end
end
