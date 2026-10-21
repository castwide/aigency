# frozen_string_literal: true

module Aigency
  module Workspace
    class Cp < Cmd
      description 'Run the `cp` shell command in your workspace'

      def command = 'cp'
    end
  end
end
