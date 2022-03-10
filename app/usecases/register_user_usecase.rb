class RegisterUserUsecase < BaseUsecase
  def perform(name:, email:, account:)
    user = User.activate(name: name, email: email, account: Account.new(account))

    if user.save
      succeeded(user: user)
    else
      failed(user: user)
    end
  end
end
