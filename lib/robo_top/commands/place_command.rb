# frozen_string_literal: true

module RoboTop
  module Commands
    # An instruction to place {Robot} at a specific ({Robot#x x}, {Robot#y y}) and
    # {Robot#orientation orientation}.
    class PlaceCommand < Command
      require 'robo_top/direction'

      ##
      # The X coord from the instruction
      #
      # Returns Integer
      attr_reader :x

      ##
      # The Y coord from the instruction
      #
      # Returns Integer
      attr_reader :y

      ##
      # The f (facing) direction from the instruction
      #
      # Returns String
      attr_reader :f

      ##
      # The {Direction} that {f} corresponds to
      #
      # Returns {Direction}
      attr_reader :orientation

      ##
      # Regexp with named captures that correlate with each {Command} type.
      # To provide API consistency, unrecognised command patterns are named :null.
      # See {NullCommand} and {Commands::Parser#sanitized_command} for more on how null
      # matches are handled.
      COMMAND_FORMAT = /\A(?:
        PLACE\s(?<x>\d+),(?<y>\d+),(?<f>#{Direction::ALL.to_a.join("|")})
      )\Z/x.freeze

      ##
      # Parse PlaceCommand and set attrs
      #
      # instruction - A valid PLACE command (e.g. "PLACE 2,3,WEST")
      #
      def initialize(instruction)
        super
        match_data = instruction.match(COMMAND_FORMAT)
        @x = match_data[:x].to_i
        @y = match_data[:y].to_i
        @f = match_data[:f]
        @orientation = Direction.named(@f)
      end
    end
  end
end
