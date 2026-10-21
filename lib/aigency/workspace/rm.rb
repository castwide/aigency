# frozen_string_literal: true

module Aigency
  module Workspace
    class Rm < Cmd
      description 'Run the `rm` shell command in your workspace'

      def command = 'rm'
    end
  end
end
