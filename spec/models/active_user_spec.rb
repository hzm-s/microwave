require 'rails_helper'

describe ActiveUser do
  describe 'validation' do
    let(:valid) do
      {
        user: User.new,
        email: 'user@example.com',
        name: 'user name',
        avatar_url: 'http://avatar.url'
      }
    end

    it do
      expect(described_class.new(valid)).to be_valid
    end

    it do
      aggregate_failures do
        expect(described_class.new(valid.merge(name: ''))).to_not be_valid
        expect(described_class.new(valid.merge(email: ''))).to_not be_valid
        expect(described_class.new(valid.merge(email: 'email'))).to_not be_valid
      end
    end
  end
end
