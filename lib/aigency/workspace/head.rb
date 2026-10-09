# frozen_string_literal: true

module Aigency
  module Workspace
    class Head < Shell
      desc 'Run the `head` shell command in your workspace'

      def command = 'head'
    end

    Tools.register Head
  end
end
