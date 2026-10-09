# frozen_string_literal: true

module Aigency
  module Workspace
    class Rm < Shell
      desc 'Run the `rm` shell command in your workspace'

      def command = 'rm'
    end

    Tools.register Rm
  end
end
