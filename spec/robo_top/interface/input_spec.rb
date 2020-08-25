# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/interface/input'

RSpec.describe RoboTop::Interface::Input do
  describe '#request_instruction' do
    it 'calls gets() from $stdin' do
      expect($stdin).to receive(:gets).and_return("MOVE\n")
      RoboTop::Interface::Input.new.request_instruction
    end
  end
end
