# frozen_string_literal: true

module RoboTop
  # A Robot that receives instructions in the form of {Commands} to help it navigate
  # around a {Table}.
  class Robot
    require 'robo_top/logging'
    require "robo_top/commands"

    include RoboTop::Logging
    include RoboTop::Commands
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
    # The {Table} that self is currently placed on
    attr_accessor :table

    protected :table

    def initialize
      @placed = false
      log('Booting new robot')
    end

    ##
    # Is this {Robot} currently on a {Table}?
    def placed?
      @table.present?
    end

    ##
    # Attempt to execute a {Commands Command} object on {Table}. If command is a
    # {Commands::NullCommand null command} or invalid, will fail gracefully.
    def attempt_command(command_string, table)
      log("Attempting command '#{command_string}'...")
      command = Commands::Parser.new(command_string).sanitized_command
      case command
      when LeftCommand then left
      when RightCommand then right
      when MoveCommand then move
      when ReportCommand then report
      when PlaceCommand
        direction = RoboTop::Direction.named(command.f)
        place(command.x, command.y, direction, table)
      else
        do_nothing
      end
    end

    def place(x, y, direction, table)
      if table.in_bounds?(x, y)
        self.x = x
        self.y = y
        self.orientation = direction
        self.table = table
        log("Placed at #{x},#{y} on table #{table} facing #{f}")
      else
        log("Cannot place #{x},#{y}. Out of table bounds #{table}")
      end
    end

    def left
      if placed?
        self.orientation = orientation.left
        log("Turned left")
      else
        log("Not placed. Returning.")
      end
    end

    def right
      if placed?
        self.orientation = orientation.right
        log("Turned right")
      else
        log("Not placed. Returning.")
      end
    end

    def move
      if placed?
        send(:"move_#{orientation.name.downcase}", table)
      else
        log("Not placed. Returning.")
      end
    end

    def report
      if placed?
        output.say("#{x},#{y},#{orientation}")
        log("Reported position")
      else
        log("Not placed. Returning.")
      end
    end

    def do_nothing
      # :noop:
    end

    private

    def output
      @output ||= Interface::Output.new
    end

    def move_north(table)
      if table.in_bounds?(x, y + STEP)
        self.y += STEP
        log("Moved #{STEP} steps #{orientation}")
      else
        log("Cannot move out of table bounds #{table}")
      end
    end

    def move_east(table)
      if table.in_bounds?(x + STEP, y)
        self.x += STEP
        log("Moved #{STEP} steps #{orientation}")
      else
        log("Cannot move out of table bounds #{table}")
      end
    end

    def move_south(table)
      if table.in_bounds?(x, y - STEP)
        self.y -= STEP
        log("Moved #{STEP} steps #{orientation}")
      else
        log("Cannot move out of table bounds #{table}")
      end
    end

    def move_west(table)
      if table.in_bounds?(x - STEP, y)
        self.x -= STEP
        log("Moved #{STEP} steps #{orientation}")
      else
        log("Cannot move out of table bounds #{table}")
      end
    end
  end
end
