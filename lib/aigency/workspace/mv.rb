# frozen_string_literal: true

module Aigency
  module Workspace
    class Mv < Shell
      desc 'Run the `mv` shell command in your workspace'

      def command = 'mv'
    end

    Tools.register Mv
  end
end
