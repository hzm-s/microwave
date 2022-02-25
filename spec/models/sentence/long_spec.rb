require 'rails_helper'

describe Sentence::Long do
  describe 'construction' do
    it do
      aggregate_failures do
        expect{ described_class.new('a' * 2) }.to raise_error ArgumentError, 'invalid_long_sentence'
        expect{ described_class.new('a' * 3) }.to_not raise_error
        expect{ described_class.new('a' * 1000) }.to_not raise_error
        expect{ described_class.new('a' * 1001) }.to raise_error ArgumentError, 'invalid_long_sentence'
      end
    end
  end
end
