# frozen_string_literal: true

module RoboTop
  module Commands
    # A null object, introduced for API consistency when an invalid instruction is passed
    # to {Robot}. This object simplifies the code by ensuring that every instruction is
    # handled in the same way, whether it's valid or not.
    class NullCommand < Command
      def initialize(*)
        @instruction = ''
      end
    end
  end
end
