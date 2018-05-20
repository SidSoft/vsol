class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def social_user
    @social_user ||= session[:social_user] if session[:social_user]
  end
  helper_method :social_user

end
