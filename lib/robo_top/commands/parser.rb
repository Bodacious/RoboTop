# frozen_string_literal: true

module RoboTop
  module Commands
    ##
    # Takes a String of user input and parses it to determine what kind of {Command}
    # it is. Provides an instance method for creating a {Command} for {Robot} that
    # is guaranteed to be understood by {Robot}.
    #
    # Examples
    #
    #   @parser = Parser.new("LEFT")
    #   @parser.sanitized_command # => Commands::LeftCommand
    #   @parser = Parser.new("INVALID")
    #   @parser.sanitized_command # => Commands::NullCommand
    #   @parser = Parser.new("PLACE 2,3,NORTH")
    #   @parser.sanitized_command # => Commands::PlaceCommand
    #
    #
    class Parser
      require 'active_support/core_ext/string'
      require 'robo_top/direction'

      require_relative 'command'
      require_relative 'left_command'
      require_relative 'right_command'
      require_relative 'report_command'
      require_relative 'place_command'
      require_relative 'move_command'
      require_relative 'null_command'

      ##
      # Regexp with named captures that correlate with each {Command} type.
      # To provide API consistency, unrecognised command patterns are named :null.
      # See {NullCommand} and {#sanitized_command} for more on how null matches are
      # handled.
      COMMAND_FORMAT = /\A(?:
        (?<report>REPORT)|
        (?<move>MOVE)|
        (?<left>LEFT)|
        (?<right>RIGHT)|
        (?<place>PLACE\s\d+,\d+,(#{Direction::ALL.to_a.join("|")}))|
        (?<null>.*)
      )\Z/x.freeze

      ##
      # The content of the given command
      attr_reader :content

      ##
      # Private: Match object showing captured matches when comparing {#content} with
      # {COMMAND_FORMAT}.
      #
      # Returns MatchData
      attr_reader :match_data

      private :match_data

      # Parse a new String
      #
      # content - A String with a single instruction for {Robot}
      #
      def initialize(content)
        @content = content.to_s.strip
        @match_data = self.content.match(COMMAND_FORMAT)
      end

      ##
      # Parse the {#content} of the given String and, if valid, return a safe instance of
      # the approptiate {Command} subclass. When the given String is not valid, will
      # return an instance of {NullCommand}.
      #
      # Returns Command
      def sanitized_command
        capture_name = match_data.named_captures.reject { |_k, v| v.nil? }.keys.first
        command_class_name = capture_name.to_s.classify + 'Command'
        command_class = Commands.const_get(command_class_name)
        command_class.new(content)
      end
    end
  end
end
