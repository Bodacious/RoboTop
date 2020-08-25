# frozen_string_literal: true

module RoboTop
  module Interface
    # Handles input from user to {Robot}
    class Input
      ##
      # Request the user type an instruction in STDIN for a {Robot}.
      def request_instruction
        $stdin.gets
      end
    end
  end
end
