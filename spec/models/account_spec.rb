require 'rails_helper'

describe Account do
  describe 'validation' do
    let(:valid) do
      {
        provider: 'google',
        uid: 'uid1234567890',
      }
    end

    it do
      expect(described_class.new(valid)).to be_valid
    end

    it do
      aggregate_failures do
        expect(described_class.new(valid.merge(provider: ''))).to_not be_valid
        expect(described_class.new(valid.merge(uid: ''))).to_not be_valid
      end
    end
  end
end
