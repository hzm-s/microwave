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

  describe 'initials' do
    it do
      aggregate_failures do
        expect(described_class.new('user.name@example.com').initials).to eq 'un'
        expect(described_class.new('user_name@example.com').initials).to eq 'us'
      end
    end
  end
end
