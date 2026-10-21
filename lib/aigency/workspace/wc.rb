# frozen_string_literal: true

module Aigency
  module Workspace
    class Wc < Cmd
      description 'Run the `wc` shell command in your workspace'

      def command = 'wc'

      def prohibited_arguments = %w[--files0-from]
    end
  end
end
