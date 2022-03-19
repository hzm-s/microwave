require 'rails_helper'

describe ActiveUser do
  describe 'new with account' do
    it do
      account = Account.new(provider: 'google', uid: 'uid1234567890')
      email = Email.new('user@example.com')

      active_user = described_class.new_with_account(name: 'user name', email: email, account: account)

      expect(active_user.initials).to eq email.initials
    end
  end

  describe 'validation' do
    let(:valid) do
      {
        user: User.new,
        email: 'user@example.com',
        name: 'user name',
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
