# frozen_string_literal: true

module RoboTop
  module Interface
    # Displays information to the user
    class Output
      require 'gemoji'

      # Prompt the user to type an instruction
      def notify_awaiting_instructions
        say('Awaiting instructions...')
      end

      # Notify the user that instructions are being processed
      def notify_processing_instructions
        say('Processing instructions...')
      end

      # Notify the user that instructions have been processed
      def notify_instructions_completed
        say('Instructions completed.')
      end

      # Display a message to the user with a robot emoji.
      #
      # text - String with message to user
      #
      def say(text)
        puts "#{robot_emoji}: #{text}"
      end

      # Display a message to the user as a plain String.
      #
      # text - String with message to user
      def display(text)
        puts text
      end

      private

      def robot_emoji
        Emoji.find_by_alias('robot').raw
      end
    end
  end
end
