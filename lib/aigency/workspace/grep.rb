# frozen_string_literal: true

module Aigency
  module Workspace
    class Grep < Cmd
      desc 'Run the `grep` shell command in your workspace'

      def command = 'grep'

      def non_path_arguments = %w[PATTERN]

      def prohibited_arguments = %w[-f --file]
    end
  end
end
