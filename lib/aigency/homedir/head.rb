# frozen_string_literal: true

module Aigency
  module Homedir
    class Head < Shell
      desc 'Run the `head` shell command in your homedir'

      def command = 'head'
    end
  end
end
