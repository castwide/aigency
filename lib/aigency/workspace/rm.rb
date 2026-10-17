# frozen_string_literal: true

module Aigency
  module Workspace
    class Rm < Cmd
      desc 'Run the `rm` shell command in your workspace'

      def command = 'rm'
    end
  end
end
