require 'rails_helper'

describe Sentence::Short do
  describe 'construction' do
    it do
      aggregate_failures do
        expect{ described_class.new('a') }.to raise_error ArgumentError, 'invalid_short_sentence'
        expect{ described_class.new('a' * 2) }.to_not raise_error
        expect{ described_class.new('a' * 500) }.to_not raise_error
        expect{ described_class.new('a' * 501) }.to raise_error ArgumentError, 'invalid_short_sentence'
      end
    end
  end
end
