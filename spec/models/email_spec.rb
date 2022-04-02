require 'rails_helper'

describe Email do
  describe 'construction' do
    it do
      aggregate_failures do
        expect{ described_class.new('') }.to raise_error ArgumentError, 'invalid_email'
        expect{ described_class.new('user@example.com') }.to_not raise_error
      end
    end
  end
end
