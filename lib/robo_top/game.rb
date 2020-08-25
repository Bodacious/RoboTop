# frozen_string_literal: true

module RoboTop
  ##
  # When the application is run, a single {Game} is created to control the interaction
  # between user, {Robot}, and {Table}.
  class Game
    require_relative 'robot'
    require_relative 'table'
    require_relative 'interface'

    ##
    # The {Robot} being controlled
    attr_reader :robot

    ##
    # The {Table} the {Robot} is currently on
    attr_reader :table

    ##
    # Output object to display information back to the user
    attr_reader :output

    ##
    # Input object to receive instructions from the user
    attr_reader :input

    ##
    # Create a new Game.
    #
    # robot        - The {Robot} the user is playing with
    # table_width  - The width of the table the user is playing on
    # table_length - The length of the table the user is playing on
    # input        - The input source for our {Robot "Robot's"} instructions
    # output       - The desired output source for our {Robot "Robot's"} feedback
    #
    def initialize(robot:,
                   table_width: 5,
                   table_length: 5,
                   input: Interface::Input.new,
                   output: Interface::Output.new)
      @table = Table.new(table_width.to_i, table_length.to_i)
      @robot = robot
      @input = input
      @output = output
    end

    ##
    # Tell the {robot} to process instructions from the user. If no list of instructions
    # is provided, system will ask for instructions via {input}.
    #
    # list - An Array of instructions as Strings (defaults: nil)
    #
    #
    def process_instructions(list = nil)
      if list
        output.notify_processing_instructions
        process_instructions_list(list)
        output.notify_instructions_completed
      else
        output.notify_awaiting_instructions
        await_instructions
      end
    end

    private

    def process_instructions_list(list)
      list.each do |string|
        command = Commands::Parser.new(string).sanitized_command
        @robot.attempt_command(command, table)
      end
    end

    def await_instructions
      loop do
        command = Commands::Parser.new(input.request_instruction).sanitized_command
        @robot.attempt_command(command, table)
      end
    end
  end
end
