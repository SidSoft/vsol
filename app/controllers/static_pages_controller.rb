class StaticPagesController < ApplicationController
  before_action :granted_user, only: [:top_secret]

      def home
    @title = "Home"
  end

  def top_secret
    @title = "Top Secret"
  end
  
  private

  def granted_user
    unless logged_in? || social_user
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
