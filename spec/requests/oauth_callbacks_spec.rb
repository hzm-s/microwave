require 'rails_helper'

describe '/auth/:provider/callback' do
  let!(:other_user) { sign_up }

  before do
    @session = {}
    allow_any_instance_of(OauthCallbackController).to receive(:session) { @session }
  end

  context 'when NOT signed up' do
    let(:auth_hash) { mock_auth_hash }

    before { set_auth_hash(auth_hash) }

    it do
      expect { get oauth_callback_path(provider: auth_hash['provider']) }
        .to change(User, :count).by(1)
        .and change(ActiveUser, :count).by(1)
        .and change(Account, :count).by(1)
    end

    it do
      get oauth_callback_path(provider: auth_hash['provider'])

      registered_account = Account.new(provider: auth_hash['provider'], uid: auth_hash['uid'])
      expect(@session[:user_id]).to eq User.find_active_by_account(registered_account).id
    end

    it do
      get oauth_callback_path(provider: auth_hash['provider'])
      expect(response).to redirect_to dashboard_path
    end
  end

  context 'when signed up' do
    let!(:user) { sign_up(auth_hash) }
    let(:auth_hash) { mock_auth_hash }

    before { set_auth_hash(auth_hash) }

    it do
      expect { get oauth_callback_path(provider: auth_hash['provider']) }
        .to change(User, :count).by(0)
        .and change(ActiveUser, :count).by(0)
        .and change(Account, :count).by(0)
    end

    context 'when NOT signed in' do
      it do
        get oauth_callback_path(provider: auth_hash['provider'])
        expect(@session[:user_id]).to eq user.id
      end

      it do
        get oauth_callback_path(provider: auth_hash['provider'])
        expect(response).to redirect_to dashboard_path
      end
    end

    context 'when signed in' do
      before { sign_in(user) }

      it do
        expect_any_instance_of(OauthCallbackController).to_not receive(:sign_in)
        get oauth_callback_path(provider: auth_hash['provider'])
      end
    end
  end
end
