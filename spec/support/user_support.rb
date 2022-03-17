require 'securerandom'

module UserSupport
  def sign_up(auth_hash = mock_auth_hash)
    attrs = {
      name: auth_hash['info']['name'],
      email: auth_hash['info']['email'],
      account: Account.new(provider: auth_hash['provider'], uid: auth_hash['uid']),
    }
    FindOrRegisterUserUsecase.perform(**attrs).user
  end
end

RSpec.configure do |c|
  c.include UserSupport
end
