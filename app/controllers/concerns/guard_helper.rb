module GuardHelper
  def require_user
    unless signed_in?
      redirect_to sign_in_path
    end
  end

  def require_guest
    if signed_in?
      redirect_to dashboard_path
    end
  end
end
