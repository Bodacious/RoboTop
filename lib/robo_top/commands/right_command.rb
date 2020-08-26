# frozen_string_literal: true

module RoboTop
  module Commands
    # An instruction to turn {Robot} right by 90 deg
    class RightCommand < Command
      def initialize(*)
        @instruction = 'RIGHT'
      end
    end
  end
end
