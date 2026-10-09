# frozen_string_literal: true

module Aigency
  module Workspace
    class Wc < Shell
      desc 'Run the `wc` shell command in your workspace'

      def command = 'wc'

      def prohibited_arguments = %w[--files0-from]
    end

    Tools.register Wc
  end
end
