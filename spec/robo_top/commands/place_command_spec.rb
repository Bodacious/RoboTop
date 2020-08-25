# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/commands/place_command'
require 'shared_examples/command'
RSpec.describe RoboTop::Commands::PlaceCommand do
  subject { RoboTop::Commands::PlaceCommand.new('PLACE 1,2,NORTH') }
  it_behaves_like 'a Command'

  describe '#x' do
    it 'is parsed from the string' do
      expect(subject.x).to eql(1)
    end
  end
  describe '#y' do
    it 'is parsed from the string' do
      expect(subject.y).to eql(2)
    end
  end
  describe '#f' do
    it 'is parsed from the string' do
      expect(subject.f).to eql('NORTH')
    end
  end
  describe '#orientation' do
    it "is computed from the 'f' value" do
      expect(subject.orientation).to eql(RoboTop::Direction::NORTH)
    end
  end
end
