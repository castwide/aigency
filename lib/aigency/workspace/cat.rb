# frozen_string_literal: true

module Aigency
  module Workspace
    class Cat < Cmd
      description 'Run the `cat` shell command in your workspace'

      def command = 'cat'
    end
  end
end
