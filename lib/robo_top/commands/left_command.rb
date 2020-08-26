# frozen_string_literal: true

module RoboTop
  module Commands
    # An instruction to turn {Robot} left by 90 deg
    class LeftCommand < Command
      def initialize(*)
        @instruction = 'LEFT'
      end
    end
  end
end
