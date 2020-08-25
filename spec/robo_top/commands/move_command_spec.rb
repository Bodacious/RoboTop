# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/commands/move_command'
require 'shared_examples/command'
RSpec.describe RoboTop::Commands::MoveCommand do
  subject { RoboTop::Commands::MoveCommand.new('MOVE') }
  it_behaves_like 'a Command'
end
