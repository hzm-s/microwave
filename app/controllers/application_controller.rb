class ApplicationController < ActionController::Base
  def sign_in(user)
    reset_session

    session[:user_id] = user.id
  end

  def current_user
    @__current_user ||= User.find_by(id: session[:user_id])
  end
end
