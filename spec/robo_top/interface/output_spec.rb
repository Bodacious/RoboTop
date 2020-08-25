# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RoboTop::Interface::Output do
  describe '#say' do
    it 'prints given string to STDOUT with robot emoji' do
      expect { subject.say('test') }.to output("\u{01F916}: test\n").to_stdout
    end
  end
  describe '#display' do
    it 'prints given string to STDOUT' do
      expect { subject.display('test') }.to output("test\n").to_stdout
    end
  end
  describe '#notify_awaiting_instructions' do
    it 'prints required message string to STDOUT' do
      expect do
        subject.notify_awaiting_instructions
      end.to output("\u{01F916}: Awaiting instructions...\n").to_stdout
    end
  end
  describe '#notify_processing_instructions' do
    it 'prints required message string to STDOUT' do
      expect do
        subject.notify_processing_instructions
      end.to output("\u{01F916}: Processing instructions...\n").to_stdout
    end
  end

  describe '#notify_instructions_completed' do
    it 'prints required message string to STDOUT' do
      expect do
        subject.notify_instructions_completed
      end.to output("\u{01F916}: Instructions completed.\n").to_stdout
    end
  end
end
