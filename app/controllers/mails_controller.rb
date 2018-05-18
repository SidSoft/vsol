class MailsController < ApplicationController
  before_action :is_admin

  def new
    @title = "NewMail"
    @smail = Smail.new
  end

  def list
    @title = "Mails"
    @smails = Smail.order(:scheduled_at).all
  end

  def create
    @smail = Smail.new(smail_params)
    if @smail.save
      flash[:info] = "New mail created."
      redirect_to(mails_list_url)
    else
      render 'new'
    end
  end

  def delete
    Smail.find(params[:id]).destroy
    flash[:success] = "Mail task deleted"
    redirect_to(mails_list_url)
  end

  def scheduled_email
    @users = User.first(3)
    mail = Smail.find(params[:id])
    @message = mail.message
    @users.each do |user|
      @user = user
      UserMailer.scheduled(@user, @message).deliver
    end
    Smail.find(params[:id]).destroy
    flash[:success] = "Mail send. Mail task deleted"
    redirect_to(mails_list_url)
  end

  private

  def smail_params
    params.require(:smail).permit(:message, :scheduled_at)
  end

  def is_admin
    redirect_to(root_url) unless current_user.admin?
  end
end
