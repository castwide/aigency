# frozen_string_literal: true

module Aigency
  module Workspace
    class Cp < Shell
      desc 'Run the `cp` shell command in your workspace'

      def command = 'cp'
    end

    Tools.register Cp
  end
end
