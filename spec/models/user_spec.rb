require 'rails_helper'

describe User do
  let(:name) { 'user name' }
  let(:email) { 'user@example.com' }
  let(:avatar_url) { 'http://avatar.url' }
  let(:account) { Account.new(provider: :google, uid: 'uid123456789') }

  describe 'activate' do
    it do
      user = described_class.activate(name: name, email: email, avatar_url: avatar_url, account: account)

      aggregate_failures do
        expect(user.name.to_s).to eq 'user name'
        expect(user.email.to_s).to eq 'user@example.com'
        expect(user.avatar_url.to_s).to eq avatar_url

        expect(user.active_user).to_not be_nil
        expect(user.cancelled_user).to be_nil
        expect(user).to be_active

        expect(user.accounts.size).to eq 1
        expect(user.accounts[0].provider).to eq 'google'
        expect(user.accounts[0].uid).to eq 'uid123456789'
      end
    end
  end

  describe 'cancel' do
    it do
      active = described_class.activate(name: name, email: email, avatar_url: avatar_url, account: account).tap { _1.save! }
      user = active.cancel
      user.save
      user.reload

      aggregate_failures do
        expect(user.name.to_s).to eq 'cancelled_user'
        expect(user.email).to be_nil
        expect(user.avatar_url).to be_nil

        expect(user.active_user).to be_nil
        expect(user.cancelled_user).to_not be_nil
        expect(user).to_not be_active

        expect(user.accounts.size).to eq 0
        expect(Account.find_by(provider: account.provider, uid: account.uid)).to be_nil
      end
    end
  end
end
