# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/game'
require 'stringio'
require 'timeout'

RSpec.describe RoboTop::Game do

  let(:robot) { RoboTop::Robot.new }

  let(:table) { RoboTop::Table.new }

  # IO object containing a series of commands.
  # Used to simulate both file input and user-STDIN input
  let(:commands_io) do
    StringIO.new(<<~COMMANDS)
      PLACE 0,0,NORTH
      RIGHT
      MOVE
      MOVE
      REPORT
    COMMANDS
  end

  subject { RoboTop::Game.new(robot: robot, table: table) }

  describe '#table' do
    it 'defaults to 5 cells' do
      expect(subject.table.cols).to eql(5)
    end
    it 'defaults to 5 rows' do
      expect(subject.table.rows).to eql(5)
    end
  end

  describe '#input' do
    it 'defaults to an instance of RoboTop::Interface::Input' do
      expect(subject.input).to be_a(RoboTop::Interface::Input)
    end
  end

  describe '#output' do
    it 'defaults to an instance of RoboTop::Interface::Output' do
      expect(subject.output).to be_a(RoboTop::Interface::Output)
    end
  end

  describe '#process_instructions' do
    context 'when a list provided' do
      before do
        commands_io.rewind
      end

      it 'passes commands to the robot to execute' do
        expect(robot).to receive(:attempt_command).exactly(5).times
        subject.process_instructions(commands_io)
      end
    end

    context 'when no list is provided' do
      before do
        commands_io.rewind
        $stdin = commands_io
      end

      after do
        commands_io.close
        $stdin = STDIN
      end

      it 'receives commands from stdin' do
        expect(robot).to receive(:attempt_command).at_least(5).times

        begin
          Timeout.timeout(0.05) do
            subject.process_instructions
          end
        rescue Timeout::Error
        end
      end
    end
  end
end
