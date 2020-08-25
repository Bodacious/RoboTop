# frozen_string_literal: true

require 'spec_helper'
require 'robo_top'

RSpec.describe RoboTop do
  describe 'test routine 1' do
    subject { run_routine_from_training_file('routine_1.txt') }

    it 'finishes at the expected x point' do
      subject
      expect(RoboTop.instance_variable_get('@robot').x).to eql(3)
    end

    it 'finishes at the expected y point' do
      subject
      expect(RoboTop.instance_variable_get('@robot').y).to eql(3)
    end

    it 'finishes at the expected orientation' do
      subject
      expect(RoboTop.instance_variable_get('@robot').orientation).to eql(RoboTop::Direction::NORTH)
    end
  end

  describe 'test routine 2' do
    subject { run_routine_from_training_file('routine_2.txt') }

    it 'finishes at the expected x point' do
      subject
      expect(RoboTop.instance_variable_get('@robot').x).to eql(0)
    end

    it 'finishes at the expected y point' do
      subject
      expect(RoboTop.instance_variable_get('@robot').y).to eql(2)
    end

    it 'finishes at the expected orientation' do
      subject
      expect(RoboTop.instance_variable_get('@robot').orientation).to eql(RoboTop::Direction::WEST)
    end
  end

  describe 'test routine 3' do
    subject { run_routine_from_training_file('routine_3.txt') }

    it 'finishes at the expected x point' do
      subject
      expect(RoboTop.instance_variable_get('@robot').x).to eql(1)
    end

    it 'finishes at the expected y point' do
      subject
      expect(RoboTop.instance_variable_get('@robot').y).to eql(2)
    end

    it 'finishes at the expected orientation' do
      subject
      expect(RoboTop.instance_variable_get('@robot').orientation).to eql(RoboTop::Direction::WEST)
    end
  end

  private

  def run_routine_from_training_file(filename)
    filepath = File.join('spec', 'training', filename.to_s)
    RoboTop.run_from_file!(filepath)
  end
end
