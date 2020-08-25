# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/commands/right_command'
require 'shared_examples/command'
RSpec.describe RoboTop::Commands::RightCommand do
  subject { RoboTop::Commands::RightCommand.new('RIGHT') }
  it_behaves_like 'a Command'
end
