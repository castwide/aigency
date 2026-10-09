# frozen_string_literal: true

module Aigency
  module Workspace
    class Ls < Shell
      desc 'Run the `ls` shell command in your workspace'

      def command = 'ls'
    end

    Tools.register Ls
  end
end
