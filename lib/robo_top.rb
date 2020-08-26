# frozen_string_literal: true

# RoboTop is a simple game to navigate a robot around a table. The game can be run by
# providing real-time commands, or a single text file with multiple commands.
#
# Examples
#
#   RoboTop.run_from_file!(@filepath)
#   # or for live input...
#   RoboTop.run!(@filepath)
#
module RoboTop
  require 'robo_top/game'
  require 'robo_top/commands'

  module_function

  ##
  # Run the {Game} and ask user for live input
  def run!
    setup
    @game.process_instructions
  end

  ##
  # Run the {Game} and load commands from a file
  #
  # filepath - A String or Pathname for file with a list of commands.
  def run_from_file!(filepath)
    setup
    @game.process_instructions(File.open(filepath, 'r').each_line)
  end

  class << self
    def setup
      # NOTE: Keep these instance variables available for the tests to check changes to
      # @robot
      @robot = Robot.new
      @table = Table.new
      @game  = Game.new(robot: @robot, table: @table)
    end
    private :setup
  end
end
