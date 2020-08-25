# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/commands/report_command'
require 'shared_examples/command'
RSpec.describe RoboTop::Commands::ReportCommand do
  subject { RoboTop::Commands::ReportCommand.new('REPORT') }
  it_behaves_like 'a Command'
end
