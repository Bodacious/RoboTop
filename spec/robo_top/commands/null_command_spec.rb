# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/commands/null_command'
require 'shared_examples/command'
RSpec.describe RoboTop::Commands::NullCommand do
  subject { RoboTop::Commands::NullCommand.new('---') }
  it_behaves_like 'a Command'
end
