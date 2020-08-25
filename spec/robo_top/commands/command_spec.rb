# frozen_string_literal: true

require 'spec_helper'

require 'robo_top/commands/command'

RSpec.describe RoboTop::Commands::Command do
  describe '#type' do
    it 'returns the name of the class, underscored' do
      RoboTop::Commands::FooClass = Class.new(RoboTop::Commands::Command)
      instance = RoboTop::Commands::FooClass.new('FooBar')
      expect(instance.type).to eql('foo_class')
    end
  end
end
