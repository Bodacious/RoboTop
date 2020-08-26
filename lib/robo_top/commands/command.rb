# frozen_string_literal: true

module RoboTop
  module Commands
    # Base class for text commands issued to {Robot}
    class Command

      ##
      # The String instruction for this command
      attr_reader :instruction

      # Arguments passed to initialize are ignored. This behaviour may be overwritten in
      # subclasses
      def initialize(*)
        # :noop:
      end

      # The command type as a String (e.g. 'move_command')
      #
      # Returns String
      def type
        self.class.name.demodulize.underscore
      end
    end
  end
end
