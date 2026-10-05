# frozen_string_literal: true

module Aigency
  module Homedir
    class Grep < Shell
      desc 'Run the `grep` shell command in your homedir'

      def command = 'grep'

      def first_path_argument = 1
    end
  end
end
