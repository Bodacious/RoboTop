# frozen_string_literal: true

module RoboTop
  module Commands
    # An instruction to display a {Robot Robot's} current position and orientation
    class ReportCommand < Command
      def initialize(*)
        @instruction = 'REPORT'
      end
    end
  end
end
