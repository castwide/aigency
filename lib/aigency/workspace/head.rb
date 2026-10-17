# frozen_string_literal: true

module Aigency
  module Workspace
    class Head < Cmd
      desc 'Run the `head` shell command in your workspace'

      def command = 'head'
    end
  end
end
