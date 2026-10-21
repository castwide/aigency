# frozen_string_literal: true

module Aigency
  module Workspace
    class Mv < Cmd
      description 'Run the `mv` shell command in your workspace'

      def command = 'mv'
    end
  end
end
