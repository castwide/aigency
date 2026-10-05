# frozen_string_literal: true

module Aigency
  module Homedir
    class Grep < Shell
      desc 'Run the `grep` shell command in your homedir'

      def command = 'grep'

      def non_path_arguments = %w[PATTERN]

      def prohibited_arguments = %w[-f --file]
    end

    Tools.register Grep
  end
end
