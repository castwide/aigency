# frozen_string_literal: true

module Aigency
  module Workspace
    class Diff < Cmd
      description 'Run the `diff` shell command in your workspace'

      def command = 'diff'
    end
  end
end
