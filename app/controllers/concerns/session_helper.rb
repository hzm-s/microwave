module SessionHelper
  def sign_in(user)
    reset_session
    store_user_id(user.id)
  end

  def sign_out
    reset_session
    @__current_user = nil
  end

  def current_user
    @__current_user ||= fetch_user(load_user_id)
  end

  def signed_in?
    !!current_user
  end

  private

  def fetch_user(user_id)
    User.find_by(id: user_id)
  end

  def store_user_id(user_id)
    session[:user_id] = user_id
  end

  def load_user_id
    session[:user_id]
  end
end
