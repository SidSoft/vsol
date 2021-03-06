module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    session.delete(:social_provider)
    session.delete(:social_user)
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def is_admin?
    logged_in? && current_user.admin
  end

  def current_user?(user)
    user == current_user
  end
end
