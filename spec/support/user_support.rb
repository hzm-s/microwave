require 'securerandom'

module UserSupport
  def sign_up(auth_hash = mock_auth_hash)
    attrs = {
      name: auth_hash['info']['name'],
      email: auth_hash['info']['email'],
      avatar_url: auth_hash['info']['image'],
      account: Account.new(provider: auth_hash['provider'], uid: auth_hash['uid']),
    }
    FindOrRegisterUserUsecase.perform(**attrs).user
  end

  module Requests
    def sign_in(user)
      auth_hash = auth_hash_from_account(user.accounts.first)
      set_auth_hash(auth_hash)
      get oauth_callback_path(provider: auth_hash['provider'])
    end
  end
end

RSpec.configure do |c|
  c.include UserSupport
  c.include UserSupport::Requests, type: :request
end
