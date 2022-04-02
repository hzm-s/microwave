class FindOrRegisterUserUsecase < BaseUsecase
  def perform(name:, email:, account:, avatar_url:)
    user = User.find_active_by_account(account)
    return succeeded(user: user) if user

    RegisterUserUsecase.perform(name: name, email: email, avatar_url: avatar_url, account: account)
  end
end
