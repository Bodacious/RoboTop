# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/robot'
require 'robo_top/commands'

RSpec.describe RoboTop::Robot do
  let(:table) { RoboTop::Table.new(5, 5) }

  describe '#placed?' do
    it 'is false by default' do
      expect(subject).not_to be_placed
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

  describe '#attempt_command' do
    context 'when command is LEFT and not placed' do
      let(:command) { RoboTop::Commands::LeftCommand.new }

      before do
        subject.placed = false
        subject.orientation = RoboTop::Direction::SOUTH
      end

      it "doesn't change the orientation" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :orientation)
      end

      it "doesn't change the x" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :x)
      end

      it "doesn't change the y" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :y)
      end

      it "doesn't change the placed" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :placed)
      end
    end

    context 'when command is LEFT and placed' do
      let(:command) { RoboTop::Commands::LeftCommand.new }

      before do
        subject.placed = true
        subject.orientation = RoboTop::Direction::SOUTH
      end

      it 'changed the robot orientation' do
        expect do
          subject.attempt_command(command, table)
        end.to change(subject, :orientation).to(RoboTop::Direction::EAST)
      end

      it "doesn't change the x value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :x)
      end

      it "doesn't change the y value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :y)
      end

      it "doesn't change the placed value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :placed?)
      end
    end

    context 'when command is RIGHT and not placed' do
      let(:command) { RoboTop::Commands::RightCommand.new }

      before do
        subject.placed = false
        subject.orientation = RoboTop::Direction::SOUTH
      end

      it "doesn't change the orientation" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :orientation)
      end

      it "doesn't change the x value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :x)
      end

      it "doesn't change the y value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :y)
      end

      it "doesn't change the placed value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :placed?)
      end
    end

    context 'when command is RIGHT and placed' do
      let(:command) { RoboTop::Commands::RightCommand.new }
      before do
        subject.placed = true
        subject.orientation = RoboTop::Direction::SOUTH
      end

      it 'turns the Robot right' do
        expect do
          subject.attempt_command(command, table)
        end.to change(subject, :orientation).to(RoboTop::Direction::WEST)
      end

      it "doesn't change the x value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :x)
      end

      it "doesn't change the y value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :y)
      end

      it "doesn't change the placed value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :placed?)
      end
    end

    context 'when command is MOVE and placed' do
      let(:command) { RoboTop::Commands::MoveCommand.new }

      before do
        subject.placed = true
        subject.orientation = RoboTop::Direction::EAST
        subject.x = 0
        subject.y = 1
      end

      it "moves the Robot one space in it's orientated direction" do
        expect do
          subject.attempt_command(command, table)
        end.to change(subject, :x).to(1)
      end

      it "doesn't affect the orientation" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :orientation)
      end

      it "doesn't affect the other axis" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :y)
      end

      it "doesn't affect the placed value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :placed?)
      end
    end

    context 'when command is MOVE and not placed' do
      let(:command) { RoboTop::Commands::MoveCommand.new }

      before do
        subject.placed = false
        subject.orientation = RoboTop::Direction::EAST
        subject.x = 0
        subject.y = 1
      end

      it "doesn't change the orientation" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :orientation)
      end

      it "doesn't affect the x value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :x)
      end

      it "doesn't affect the y value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :y)
      end

      it "doesn't affect the placed? value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :placed?)
      end
    end

    context 'when command is MOVE and out of bounds' do
      let(:command) { RoboTop::Commands::MoveCommand.new }

      before do
        subject.placed = true
        subject.orientation = RoboTop::Direction::EAST
        subject.x = 4
        subject.y = 1
      end

      it "doesn't change the orientation" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :orientation)
      end

      it "doesn't affect the x value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :x)
      end

      it "doesn't affect the y value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :y)
      end

      it "doesn't affect the placed? value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :placed?)
      end
    end

    context 'when command is REPORT and not placed' do
      let(:command) { RoboTop::Commands::ReportCommand.new }

      before do
        subject.placed = false
        subject.orientation = RoboTop::Direction::EAST
        subject.x = 0
        subject.y = 1
      end

      it 'does nothing' do
        expect do
          subject.attempt_command(command, table)
        end.not_to output.to_stdout
      end
      it "doesn't change the orientation" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :orientation)
      end

      it "doesn't affect the x value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :x)
      end

      it "doesn't affect the y value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :y)
      end

      it "doesn't affect the placed? value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :placed?)
      end
    end

    context 'when command is REPORT and robot is placed' do
      let(:command) { RoboTop::Commands::ReportCommand.new }

      before do
        subject.placed = true
        subject.orientation = RoboTop::Direction::EAST
        subject.x = 0
        subject.y = 1
      end

      it 'prints coords and orientation to STDERR' do
        expect do
          subject.attempt_command(command, table)
        end.to output("0,1,EAST\n").to_stdout
      end

      it "doesn't change the orientation" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :orientation)
      end

      it "doesn't affect the x value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :x)
      end

      it "doesn't affect the y value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :y)
      end

      it "doesn't affect the placed? value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :placed?)
      end
    end

    context 'when command is PLACE' do
      let(:command) do
        RoboTop::Commands::PlaceCommand.new('PLACE 2,3,WEST')
      end

      before do
        subject.placed = false
      end

      it "sets the robot's placed value to true" do
        expect { subject.attempt_command(command, table) }.to change(subject, :placed?).to(true)
      end

      it "sets the robot's x value" do
        expect do
          subject.attempt_command(command, table)
        end.to change(subject, :x).to(2)
      end

      it "sets the robot's y value" do
        expect do
          subject.attempt_command(command, table)
        end.to change(subject, :y).to(3)
      end

      it "sets the robot's orientation value" do
        expect do
          subject.attempt_command(command, table)
        end.to change(subject, :orientation).to(RoboTop::Direction::WEST)
      end
    end

    context 'when command is PLACE and out of bounds' do
      let(:command) do
        RoboTop::Commands::PlaceCommand.new('PLACE 9,9,WEST')
      end

      before do
        subject.placed = false
      end

      it "doesn't change the robot's placed value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :placed?)
      end

      it "doesn't set the robot's x value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :x)
      end

      it "doesn't set the robot's y value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :y)
      end

      it "doesn't set the robot's orientation value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :orientation)
      end
    end

    context 'when command is a NullCommand and robot placed' do
      let(:command) { RoboTop::Commands::NullCommand.new }

      before do
        subject.placed = true
      end

      it "doesn't change the placed value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :placed?)
      end

      it "doesn't change the x value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :x)
      end

      it "doesn't change the y value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :y)
      end

      it "doesn't change the orientation state" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :orientation)
      end
    end

    context 'when command is a NullCommand and robot not placed' do
      let(:command) { RoboTop::Commands::NullCommand.new }

      before do
        subject.placed = false
      end

      it "doesn't change the placed value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :placed?)
      end

      it "doesn't change the x value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :x)
      end

      it "doesn't change the y value" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :y)
      end

      it "doesn't change the orientation state" do
        expect do
          subject.attempt_command(command, table)
        end.not_to change(subject, :orientation)
      end
    end
  end
end
