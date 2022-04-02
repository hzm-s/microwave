class RegisterUserUsecase < BaseUsecase
  def perform(name:, email:, avatar_url:, account:)
    user = User.activate(name: name, email: email, avatar_url: avatar_url, account: account)

    if user.save
      succeeded(user: user)
    else
      failed(user: user)
    end
  end
end
