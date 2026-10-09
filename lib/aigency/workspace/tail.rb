# frozen_string_literal: true

module Aigency
  module Workspace
    class Tail < Shell
      desc 'Run the `tail` shell command in your workspace'

      def command = 'tail'
    end
  end
end
