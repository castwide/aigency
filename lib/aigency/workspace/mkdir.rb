# frozen_string_literal: true

module Aigency
  module Workspace
    class Mkdir < Cmd
      desc 'Run the `mkdir` shell command in your workspace'

      def command = 'mkdir'
    end
  end
end
