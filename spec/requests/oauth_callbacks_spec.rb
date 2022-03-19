require 'rails_helper'

describe '/auth/:provider/callback' do
  context 'when NOT signed up' do
    let(:auth_hash) { mock_auth_hash }

    before { set_auth_hash(auth_hash) }

    it 'register user' do
      expect { get oauth_callback_path(provider: auth_hash['provider']) }
        .to change(User, :count).by(1)
        .and change(ActiveUser, :count).by(1)
        .and change(Account, :count).by(1)
    end
  end

  context 'when signed up' do
    let(:auth_hash) { mock_auth_hash }

    before do
      sign_up(auth_hash)
      set_auth_hash(auth_hash)
    end

    it do
      expect { get oauth_callback_path(provider: auth_hash['provider']) }
        .to change(User, :count).by(0)
        .and change(ActiveUser, :count).by(0)
        .and change(Account, :count).by(0)
    end
  end
end
