class ApplicationController < ActionController::Base
  def require_user
    unless signed_in?
      redirect_to sign_in_path
    end
  end

  def signed_in?
    !!current_user
  end

  def sign_in(user)
    reset_session
    session[:user_id] = user.id
  end

  def sign_out
    reset_session
    @__current_user = nil
  end

  def current_user
    @__current_user ||= User.find_by(id: session[:user_id])
  end
end
