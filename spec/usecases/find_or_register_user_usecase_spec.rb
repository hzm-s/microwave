require 'rails_helper'

describe FindOrRegisterUserUsecase do
  let(:name) { 'user name' }
  let(:email) { 'user@example.com' }
  let(:avatar_url) { 'http://avatar.url' }
  let(:account) { Account.new(provider: 'google', uid: 'uid123456789') }

  before do
    RegisterUserUsecase.perform(
      name: 'other user',
      email: 'other.user@example.com',
      avatar_url: 'http://other.user/image',
      account: Account.new(provider: 'google', uid: 'uid987654321'),
    )
  end

  context 'when NOT registered' do
    it do
      result = described_class.perform(name: name, email: email, avatar_url: avatar_url, account: account)

      expected_user =
        Account
        .find_by({ provider: account.provider, uid: account.uid })
        .then { ActiveUser.find(_1.active_user_id) }
        .then { User.find(_1.user_id) }

      aggregate_failures do
        expect(result).to be_succeeded
        expect(result.user).to_not be_nil
        expect(result.user).to eq expected_user
      end
    end
  end

  context 'when registered' do
    let!(:registered_user) do
      RegisterUserUsecase.perform(name: name, email: email, avatar_url: avatar_url, account: account).user
    end

    it do
      result = described_class.perform(name: name, email: email, avatar_url: avatar_url, account: account)

      aggregate_failures do
        expect(result).to be_succeeded
        expect(result.user).to eq registered_user
      end
    end
  end
end
