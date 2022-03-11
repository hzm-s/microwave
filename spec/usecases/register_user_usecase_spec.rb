require 'rails_helper'

describe RegisterUserUsecase do
  let(:name) { 'user name' }
  let(:email) { 'user@example.com' }
  let(:account) { Account.new(provider: 'google', uid: 'uid123456789') }

  context 'valid params' do
    it do
      result = described_class.perform(name: name, email: email, account: account)

      aggregate_failures do
        expect(result).to be_succeeded

        user = User.find(result.user.id)
        expect(user.name.to_s).to eq name
        expect(user.email.to_s).to eq email
        expect(user.accounts[0].provider).to eq account[:provider]
        expect(user.accounts[0].uid).to eq account[:uid]
      end
    end
  end

  context 'invalid params' do
    it do
      result = described_class.perform(name: name, email: '', account: account)

      aggregate_failures do
        expect(result).to_not be_succeeded
        expect(User.count).to eq 0
        expect(ActiveUser.count).to eq 0
        expect(Account.count).to eq 0
      end
    end
  end
end
