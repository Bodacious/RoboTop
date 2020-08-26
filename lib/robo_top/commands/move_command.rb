# frozen_string_literal: true

module RoboTop
  module Commands
    # An instruction to move {Robot} forwards by {Robot::STEP} number of spaces
    class MoveCommand < Command
      def initialize(*)
        @instruction = 'MOVE'
      end
    end
  end
end
