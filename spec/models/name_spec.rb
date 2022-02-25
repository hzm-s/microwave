require 'rails_helper'

describe Name do
  describe 'construction' do
    it do
      aggregate_failures do
        expect{ described_class.new('') }.to raise_error ArgumentError, 'invalid_name'
        expect{ described_class.new('a') }.to_not raise_error
        expect{ described_class.new('a' * 50) }.to_not raise_error
        expect{ described_class.new('a' * 51) }.to raise_error ArgumentError, 'invalid_name'
      end
    end
  end
end
