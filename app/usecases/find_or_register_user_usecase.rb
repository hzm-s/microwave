class FindOrRegisterUserUsecase < BaseUsecase
  def perform(name:, email:, account:)
    user = User.find_active_by_account(account)
    return succeeded(user: user) if user

    RegisterUserUsecase.perform(name: name, email: email, account: account)
  end
end
