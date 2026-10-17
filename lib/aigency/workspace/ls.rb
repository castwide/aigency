# frozen_string_literal: true

module Aigency
  module Workspace
    class Ls < Cmd
      desc 'Run the `ls` shell command in your workspace'

      def command = 'ls'
    end
  end
end
