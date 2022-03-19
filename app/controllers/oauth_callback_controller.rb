class OauthCallbackController < ApplicationController
  def create
    result = FindOrRegisterUserUsecase.perform(
      name: auth_hash.name,
      email: auth_hash.email,
      account: Account.new(auth_hash.account),
    )
    sign_in(result.user)
    redirect_to dashboard_path
  end

  private

  def auth_hash
    @__auth_hash ||= OauthAuthHash.new(request.env['omniauth.auth'])
  end
end
