# frozen_string_literal: true

module Aigency
  module Workspace
    class Mkdir < Shell
      desc 'Run the `mkdir` shell command in your workspace'

      def command = 'mkdir'
    end

    Tools.register Mkdir
  end
end
