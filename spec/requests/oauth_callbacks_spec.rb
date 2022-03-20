require 'rails_helper'

describe '/auth/:provider/callback' do
  let!(:other_user) { sign_up }

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
      expect_any_instance_of(OauthCallbackController).to receive(:sign_in)
      get oauth_callback_path(provider: auth_hash['provider'])
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
        expect_any_instance_of(OauthCallbackController).to receive(:sign_in).with(user)
        get oauth_callback_path(provider: auth_hash['provider'])
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
