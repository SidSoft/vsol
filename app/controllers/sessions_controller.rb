class SessionsController < ApplicationController

  def new
    @title = "Login"
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        redirect_to user
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def create_social
    session[:social_provider] = auth_hash.provider
    if auth_hash.provider == 'twitter'
      session[:social_user] = auth_hash.info.nickname
      session[:social_icon] = 'twitter'
    elsif auth_hash.provider == 'google_oauth2'
      session[:social_user] = auth_hash.info.name
      session[:social_icon] = 'google-plus'
    else
      session[:social_user] = 'Social User'
    end
    redirect_to root_path
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def sandbox
    @title = "Sandbox"
    run DelayedJobWeb
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
