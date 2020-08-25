# frozen_string_literal: true

module RoboTop
  # A Robot that receives instructions in the form of {Commands} to help it navigate
  # around a {Table}.
  class Robot
    require 'robo_top/logging'
    include RoboTop::Logging

    ##
    # How many spaces to move per MOVE command
    STEP = 1

    ##
    # {Direction} this {Robot} is currently facing
    attr_accessor :orientation

    alias f orientation

    ##
    # Point X on {Table} which this {Robot} is currently located
    attr_accessor :x

    ##
    # Point Y on {Table} which this {Robot} is currently located
    attr_accessor :y

    ##
    # Is this {Robot} currently on a {Table}?
    attr_accessor :placed
    alias placed? placed

    def initialize
      @placed = false
      logger.debug('Booting new robot')
    end

    ##
    # Attempt to execute a {Commands Command} object on {Table}. If command is a
    # {Commands::NullCommand null command} or invalid, will fail gracefully.
    def attempt_command(command, table)
      logger.debug("Attempting #{command.type} command...") if ENV['LOGGING']
      send(:"attempt_#{command.type}", command, table)
    end

    private

    def attempt_place_command(command, table)
      if table.in_bounds?(command.x, command.y)
        self.x = command.x
        self.y = command.y
        self.orientation = command.orientation
        self.placed = true
      else
        ignore_place_command(command.x, command.y, table)
      end
    end

    def attempt_left_command(_command, _table)
      return unless placed?

      self.orientation = orientation.left
    end

    def attempt_right_command(_command, _table)
      return unless placed?

      self.orientation = orientation.right
    end

    def attempt_move_command(_command, table)
      return unless placed?

      send(:"move_#{orientation.name.downcase}", table)
    end

    def attempt_report_command(_command, _table)
      return unless placed?

      output.display("#{x},#{y},#{orientation}")
    end

    def attempt_null_command(_command, _table)
      # :noop:
    end

    def output
      @output ||= Interface::Output.new
    end

    def move_north(table)
      if table.in_bounds?(x, y + STEP)
        self.y += STEP
      else
        ignore_move_command(x, y + STEP, table)
      end
    end

    def move_east(table)
      if table.in_bounds?(x + STEP, y)
        self.x += STEP
      else
        ignore_move_command(x + STEP, y, table)
      end
    end

    def move_south(table)
      if table.in_bounds?(x, y - STEP)
        self.y -= STEP
      else
        ignore_move_command(x, y - STEP, table)
      end
    end

    def move_west(table)
      if table.in_bounds?(x - STEP, y)
        self.x -= STEP
      else
        ignore_move_command(x - STEP, y, table)
      end
    end

    def ignore_place_command(x, y, table)
      if ENV['LOGGING']
        logger.debug("Ignoring PLACE command. x: #{x}, y:#{y} is not in table: #{table}")
      else
        # :noop:
      end
    end

    def ignore_move_command(x, y, table)
      if ENV['LOGGING']
        logger.debug("Ignoring MOVE command. x: #{x}, y:#{y} is not in table: #{table}")
      else
        # :noop:
      end
    end
  end
end
