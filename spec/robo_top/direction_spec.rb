# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/direction'

RSpec.describe RoboTop::Direction do
  describe '::new' do
    it 'raises an error when accessed directly' do
      expect { RoboTop::Direction.new('EAST') }.to raise_error(NoMethodError)
    end
  end
  describe '::named' do
    context 'when value is a valid direction' do
      it 'returns the singleton object for given value' do
        expect(RoboTop::Direction.named('EAST')).to eql(RoboTop::Direction::EAST)
      end

      it 'returns the same object every time' do
        expect(RoboTop::Direction.named('EAST')).to equal(RoboTop::Direction.named('EAST'))
      end
    end

    context 'when value is not a valid direction' do
      it 'raises an exception' do
        expect do
          RoboTop::Direction.named('FOOBAR')
        end.to raise_error(RoboTop::Direction::InvalidDirectionError)
      end
    end
  end
  
  describe '#right' do
    let(:current_direction) { raise NotImplementedError, 'Define current_direction' }

    subject { current_direction.right }

    context 'when NORTH' do
      let(:current_direction) { RoboTop::Direction::NORTH }

      it { is_expected.to eql(RoboTop::Direction::EAST) }
    end

    context 'when EAST' do
      let(:current_direction) { RoboTop::Direction::EAST }

      it { is_expected.to eql(RoboTop::Direction::SOUTH) }
    end

    context 'when SOUTH' do
      let(:current_direction) { RoboTop::Direction::SOUTH }

      it { is_expected.to eql(RoboTop::Direction::WEST) }
    end

    context 'when WEST' do
      let(:current_direction) { RoboTop::Direction::WEST }

      it { is_expected.to eql(RoboTop::Direction::NORTH) }
    end
  end

  describe '#left' do
    let(:current_direction) { raise NotImplementedError, 'Define current_direction' }

    subject { current_direction.left }

    context 'when NORTH' do
      let(:current_direction) { RoboTop::Direction::NORTH }

      it { is_expected.to eql(RoboTop::Direction::WEST) }
    end
    context 'when WEST' do
      let(:current_direction) { RoboTop::Direction::WEST }

      it { is_expected.to eql(RoboTop::Direction::SOUTH) }
    end
    context 'when SOUTH' do
      let(:current_direction) { RoboTop::Direction::SOUTH }

      it { is_expected.to eql(RoboTop::Direction::EAST) }
    end

    context 'when EAST' do
      let(:current_direction) { RoboTop::Direction::EAST }

      it { is_expected.to eql(RoboTop::Direction::NORTH) }
    end
  end
end
