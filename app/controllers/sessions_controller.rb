class SessionsController < ApplicationController
  before_action :require_user

  def destroy
    sign_out
    redirect_to sign_in_path
  end
end
