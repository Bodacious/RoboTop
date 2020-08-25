# frozen_string_literal: true

require 'spec_helper'
require 'robo_top/table'

RSpec.describe RoboTop::Table do
  describe '#in_bounds?' do
    let(:table) { RoboTop::Table.new(5, 5) }

    let(:x) { raise NotImplementedError, 'Please define x' }

    let(:y) { raise NotImplementedError, 'Please define y' }

    subject { table.in_bounds?(x, y) }

    context 'when valid values are passed as strings' do
      let(:x) { '4' }

      let(:y) { '4' }

      it { is_expected.to eql(true) }
    end

    context 'when x and y are both within the table bounds' do
      let(:x) { 4 }

      let(:y) { 4 }

      it { is_expected.to eql(true) }
    end

    context 'when x and y are both outside the table bounds' do
      let(:x) { 5 }

      let(:y) { 5 }

      it { is_expected.to eql(false) }
    end

    context 'when x is inside and y is outside the table bounds' do
      let(:x) { 0 }

      let(:y) { 5 }

      it { is_expected.to eql(false) }
    end

    context 'when x is outside and y is inside the table bounds' do
      let(:x) { 5 }

      let(:y) { 0 }

      it { is_expected.to eql(false) }
    end
  end

  describe '#to_s' do
    it 'prints the cols and rows in brackets' do
      expect(RoboTop::Table.new(4, 6).to_s).to eql('(4,6)')
    end
  end
end
