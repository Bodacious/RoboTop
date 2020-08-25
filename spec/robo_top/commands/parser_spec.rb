# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/commands/parser'

RSpec.describe RoboTop::Commands::Parser do
  describe '#content' do
    it 'is set on initialize' do
      expect(RoboTop::Commands::Parser.new('LEFT').content).to eql('LEFT')
    end

    it 'removes trailing carriage returns' do
      expect(RoboTop::Commands::Parser.new("LEFT\r").content).to eql('LEFT')
    end

    it 'removes trailing whitespace' do
      expect(RoboTop::Commands::Parser.new('REPORT  ').content).to eql('REPORT')
    end

    it 'removes leading whitespace' do
      expect(RoboTop::Commands::Parser.new('  MOVE').content).to eql('MOVE')
    end
  end

  describe '#sanitized_command' do
    let(:command) { raise(NotImplementedError, 'Define command in spec context block') }

    subject { RoboTop::Commands::Parser.new(command).sanitized_command }

    context 'when command is valid REPORT' do
      let(:command) { 'REPORT' }

      it 'returns a Report command' do
        expect(subject).to be_a(RoboTop::Commands::ReportCommand)
      end
    end

    context 'when command is valid MOVE' do
      let(:command) { 'MOVE' }

      it 'returns a Move command' do
        expect(subject).to be_a(RoboTop::Commands::MoveCommand)
      end
    end

    context 'when command is valid LEFT' do
      let(:command) { 'LEFT' }

      it 'returns a Left command' do
        expect(subject).to be_a(RoboTop::Commands::LeftCommand)
      end
    end

    context 'when command is valid RIGHT' do
      let(:command) { 'RIGHT' }

      it 'returns a Right command' do
        expect(subject).to be_a(RoboTop::Commands::RightCommand)
      end
    end

    context 'when command is valid PLACE' do
      let(:command) { 'PLACE 2,3,NORTH' }

      it 'returns a Place command' do
        expect(subject).to be_a(RoboTop::Commands::PlaceCommand)
      end
    end

    context 'when command f is not a valid value' do
      let(:command) { 'PLACE 2,3,N' }

      it 'returns a NullCommand' do
        expect(subject).to be_a(RoboTop::Commands::NullCommand)
      end
    end

    context 'when command is invalid FOOBAR' do
      let(:command) { 'FOOBAR' }

      it 'returns a NullCommand command' do
        expect(subject).to be_a(RoboTop::Commands::NullCommand)
      end
    end

    context 'when command is invalid nil' do
      let(:command) { nil }

      it 'returns a NullCommand command' do
        expect(subject).to be_a(RoboTop::Commands::NullCommand)
      end
    end

    context 'when command is lowercase left' do
      let(:command) { 'left' }

      it 'returns a NullCommand command' do
        expect(subject).to be_a(RoboTop::Commands::NullCommand)
      end
    end

    context 'when command is lowercase right' do
      let(:command) { 'right' }

      it 'returns a NullCommand command' do
        expect(subject).to be_a(RoboTop::Commands::NullCommand)
      end
    end

    context 'when command is lowercase report' do
      let(:command) { 'report' }

      it 'returns a NullCommand command' do
        expect(subject).to be_a(RoboTop::Commands::NullCommand)
      end
    end

    context 'when command is lowercase move' do
      let(:command) { 'move' }

      it 'returns a NullCommand command' do
        expect(subject).to be_a(RoboTop::Commands::NullCommand)
      end
    end

    context 'when command has too much whitespace' do
      let(:command) { '  right  ' }

      it 'returns a NullCommand command' do
        expect(subject).to be_a(RoboTop::Commands::NullCommand)
      end
    end

    context 'when command is invalid blank' do
      let(:command) { '' }

      it 'returns a NullCommand command' do
        expect(subject).to be_a(RoboTop::Commands::NullCommand)
      end
    end

    context 'when command is invalid PLACE' do
      let(:command) { 'PLACE,FOOBAR' }

      it 'returns a NullCommand command' do
        expect(subject).to be_a(RoboTop::Commands::NullCommand)
      end
    end
  end
end
