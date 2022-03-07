require 'rails_helper'

describe User do
  describe 'activate' do
    it do
      account = Account.new(provider: :google, uid: 'uid123456789')
      user = described_class.activate(
        name: 'user name',
        email: 'user@example.com',
        account: account,
      )

      aggregate_failures do
        expect(user.name.to_s).to eq 'user name'
        expect(user.email.to_s).to eq 'user@example.com'
        expect(user.cancelled_user).to be_nil
        expect(user).to be_active

        expect(user.accounts.size).to eq 1
        expect(user.accounts[0].provider).to eq 'google'
        expect(user.accounts[0].uid).to eq 'uid123456789'
      end
    end
  end
end
