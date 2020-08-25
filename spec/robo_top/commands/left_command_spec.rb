# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/commands/left_command'
require 'shared_examples/command'
RSpec.describe RoboTop::Commands::LeftCommand do
  subject { RoboTop::Commands::LeftCommand.new('LEFT') }
  it_behaves_like 'a Command'
end
