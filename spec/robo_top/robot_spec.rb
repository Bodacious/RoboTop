# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/robot'
require 'robo_top/commands'

RSpec.describe RoboTop::Robot do
  let(:table) { RoboTop::Table.new(5, 5) }

  let(:place_robot) do
    proc { subject.place(3, 4, RoboTop::Direction::NORTH, table) }
  end

  describe '#placed?' do
    it 'is false by default' do
      expect(subject).not_to be_placed
    end

    it 'is true when placed on a table' do
      expect(&place_robot).to change(subject, :placed?).from(false).to(true)
    end
  end

  describe '#orientation' do
    it 'is nil by default' do
      expect(subject.orientation).to be_nil
    end
  end

  describe '#x' do
    it 'is nil by default' do
      expect(subject.x).to be_nil
    end
  end

  describe '#y' do
    it 'is nil by default' do
      expect(subject.y).to be_nil
    end
  end

  describe '#left' do
    context 'when not placed' do
      before do
        subject.orientation = RoboTop::Direction::SOUTH
      end

      it "doesn't change the orientation" do
        expect do
          subject.left
        end.not_to change(subject, :orientation)
      end

      it "doesn't change the x" do
        expect do
          subject.left
        end.not_to change(subject, :x)
      end

      it "doesn't change the y" do
        expect do
          subject.left
        end.not_to change(subject, :y)
      end

      it "doesn't change the placed" do
        expect do
          subject.left
        end.not_to change(subject, :placed?)
      end
    end

    context 'when placed' do
      before do
        place_robot.call
        subject.orientation = RoboTop::Direction::SOUTH
      end

      it 'changed the robot orientation' do
        expect do
          subject.left
        end.to change(subject, :orientation).to(RoboTop::Direction::EAST)
      end

      it "doesn't change the x value" do
        expect do
          subject.left
        end.not_to change(subject, :x)
      end

      it "doesn't change the y value" do
        expect do
          subject.left
        end.not_to change(subject, :y)
      end

      it "doesn't change the placed value" do
        expect do
          subject.left
        end.not_to change(subject, :placed?)
      end
    end
  end

  describe '#right' do
    context 'when not placed' do
      before do
        subject.orientation = RoboTop::Direction::SOUTH
      end

      it "doesn't change the orientation" do
        expect do
          subject.right
        end.not_to change(subject, :orientation)
      end

      it "doesn't change the x value" do
        expect do
          subject.right
        end.not_to change(subject, :x)
      end

      it "doesn't change the y value" do
        expect do
          subject.right
        end.not_to change(subject, :y)
      end

      it "doesn't change the placed value" do
        expect do
          subject.right
        end.not_to change(subject, :placed?)
      end
    end

    context 'when placed' do
      before do
        place_robot.call
        subject.orientation = RoboTop::Direction::SOUTH
      end

      it 'turns the Robot right' do
        expect do
          subject.right
        end.to change(subject, :orientation).to(RoboTop::Direction::WEST)
      end

      it "doesn't change the x value" do
        expect do
          subject.right
        end.not_to change(subject, :x)
      end

      it "doesn't change the y value" do
        expect do
          subject.right
        end.not_to change(subject, :y)
      end

      it "doesn't change the placed value" do
        expect do
          subject.right
        end.not_to change(subject, :placed?)
      end
    end
  end

  describe '#move' do
    context 'when placed' do
      before do
        place_robot.call
        subject.orientation = RoboTop::Direction::EAST
        subject.x = 0
        subject.y = 1
      end

      it "moves the Robot one space in it's orientated direction" do
        expect do
          subject.move
        end.to change(subject, :x).to(1)
      end

      it "doesn't affect the orientation" do
        expect do
          subject.move
        end.not_to change(subject, :orientation)
      end

      it "doesn't affect the other axis" do
        expect do
          subject.move
        end.not_to change(subject, :y)
      end

      it "doesn't affect the placed value" do
        expect do
          subject.move
        end.not_to change(subject, :placed?)
      end
    end

    context 'when not placed' do
      before do
        subject.orientation = RoboTop::Direction::EAST
        subject.x = 0
        subject.y = 1
      end

      it "doesn't change the orientation" do
        expect do
          subject.move
        end.not_to change(subject, :orientation)
      end

      it "doesn't affect the x value" do
        expect do
          subject.move
        end.not_to change(subject, :x)
      end

      it "doesn't affect the y value" do
        expect do
          subject.move
        end.not_to change(subject, :y)
      end

      it "doesn't affect the placed? value" do
        expect do
          subject.move
        end.not_to change(subject, :placed?)
      end
    end

    context 'when out of bounds' do
      before do
        place_robot.call
        subject.orientation = RoboTop::Direction::EAST
        subject.x = 4
        subject.y = 1
      end

      it "doesn't change the orientation" do
        expect do
          subject.move
        end.not_to change(subject, :orientation)
      end

      it "doesn't affect the x value" do
        expect do
          subject.move
        end.not_to change(subject, :x)
      end

      it "doesn't affect the y value" do
        expect do
          subject.move
        end.not_to change(subject, :y)
      end

      it "doesn't affect the placed? value" do
        expect do
          subject.move
        end.not_to change(subject, :placed?)
      end
    end
  end

  describe '#report' do
    context 'when not placed' do
      before do
        subject.orientation = RoboTop::Direction::EAST
        subject.x = 0
        subject.y = 1
      end

      it 'does nothing' do
        expect do
          subject.report
        end.not_to output.to_stdout
      end
      it "doesn't change the orientation" do
        expect do
          subject.report
        end.not_to change(subject, :orientation)
      end

      it "doesn't affect the x value" do
        expect do
          subject.report
        end.not_to change(subject, :x)
      end

      it "doesn't affect the y value" do
        expect do
          subject.report
        end.not_to change(subject, :y)
      end

      it "doesn't affect the placed? value" do
        expect do
          subject.report
        end.not_to change(subject, :placed?)
      end
    end

    context 'when robot is placed' do
      before do
        place_robot.call
        subject.orientation = RoboTop::Direction::EAST
        subject.x = 0
        subject.y = 1
      end

      it 'prints coords and orientation to STDERR' do
        expect do
          subject.report
        end.to output("\u{01F916}: 0,1,EAST\n").to_stdout
      end

      it "doesn't change the orientation" do
        expect do
          subject.report
        end.not_to change(subject, :orientation)
      end

      it "doesn't affect the x value" do
        expect do
          subject.report
        end.not_to change(subject, :x)
      end

      it "doesn't affect the y value" do
        expect do
          subject.report
        end.not_to change(subject, :y)
      end

      it "doesn't affect the placed? value" do
        expect do
          subject.report
        end.not_to change(subject, :placed?)
      end
    end
  end
  describe '#place' do
    context 'when command is in bounds' do
      let(:command) do
        RoboTop::Commands::PlaceCommand.new('PLACE 2,3,WEST')
      end

      it "sets the robot's placed value to true" do
        expect do
          subject.place(command.x, command.y, command.orientation, table)
        end.to change(subject, :placed?).to(true)
      end

      it "sets the robot's x value" do
        expect do
          subject.place(command.x, command.y, command.orientation, table)
        end.to change(subject, :x).to(2)
      end

      it "sets the robot's y value" do
        expect do
          subject.place(command.x, command.y, command.orientation, table)
        end.to change(subject, :y).to(3)
      end

      it "sets the robot's orientation value" do
        expect do
          subject.place(command.x, command.y, command.orientation, table)
        end.to change(subject, :orientation).to(RoboTop::Direction::WEST)
      end
    end

    context 'when command is PLACE and out of bounds' do
      let(:command) do
        RoboTop::Commands::PlaceCommand.new('PLACE 9,9,WEST')
      end

      it "doesn't change the robot's placed value" do
        expect do
          subject.place(command.x, command.y, command.orientation, table)
        end.not_to change(subject, :placed?)
      end

      it "doesn't set the robot's x value" do
        expect do
          subject.place(command.x, command.y, command.orientation, table)
        end.not_to change(subject, :x)
      end

      it "doesn't set the robot's y value" do
        expect do
          subject.place(command.x, command.y, command.orientation, table)
        end.not_to change(subject, :y)
      end

      it "doesn't set the robot's orientation value" do
        expect do
          subject.place(command.x, command.y, command.orientation, table)
        end.not_to change(subject, :orientation)
      end
    end
  end

  describe '#attempt_command' do
    context 'when command is a LeftCommand' do
      let(:command) { RoboTop::Commands::LeftCommand.new }

      it 'sends tells the robot to turn left' do
        expect(subject).to receive(:left)
        subject.attempt_command(command.instruction, table)
      end
    end

    context 'when command is a RightCommand' do
      let(:command) { RoboTop::Commands::RightCommand.new }

      it 'sends tells the robot to turn right' do
        expect(subject).to receive(:right)
        subject.attempt_command(command.instruction, table)
      end
    end

    context 'when command is a MoveCommand' do
      let(:command) { RoboTop::Commands::MoveCommand.new }

      it 'sends tells the robot to move forwards' do
        expect(subject).to receive(:move)
        subject.attempt_command(command.instruction, table)
      end
    end

    context 'when command is a ReportCommand' do
      let(:command) { RoboTop::Commands::ReportCommand.new }

      it 'sends tells the robot to report its position' do
        expect(subject).to receive(:report)
        subject.attempt_command(command.instruction, table)
      end
    end

    context 'when command is a PlaceCommand' do
      let(:command) { RoboTop::Commands::PlaceCommand.new('PLACE 2,3,WEST') }

      it 'sends tells the robot to place at given cell' do
        expect(subject).to receive(:place)
          .with(2, 3, RoboTop::Direction::WEST, table)
        subject.attempt_command(command.instruction, table)
      end
    end

    context 'when command is a NullCommand' do
      let(:command) { RoboTop::Commands::NullCommand.new }

      it 'sends tells the robot to do nothing' do
        expect(subject).to receive(:do_nothing)
        subject.attempt_command(command.instruction, table)
      end
    end
  end
end
