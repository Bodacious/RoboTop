# frozen_string_literal: true

shared_examples_for 'a Command' do
  describe '#type' do
    it 'is equal to the class name underscored' do
      expect(subject.type).to eql(subject.class.name.split('::').last.underscore)
    end
  end
end
