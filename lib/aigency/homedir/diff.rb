# frozen_string_literal: true

module Aigency
  module Homedir
    class Diff < Shell
      desc 'Run the `diff` shell command in your homedir'

      def command = 'diff'
    end

    Tools.register Diff
  end
end
