class SmailsController < ApplicationController
  before_action :is_admin

  NewsletterJob = Struct.new(:users, :message) do
    def perform
      users.each do |user|
        @user = user
        UserMailer.scheduled(user, message).deliver
      end
    end
  end

  def new
    @title = "NewMail"
    @smail = Smail.new
  end

  def show
    @title = "Mail Task"
    @smail = Smail.find(params[:id])
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

  def update
    @smail = Smail.find(params[:id])
    if @smail.update_attributes(smail_params)
      flash[:success] = "Task updated"
      # redirect_to (mails_list_url)
      redirect_to(mails_list_url)
    else
      render 'show'
    end
  end

  def destroy
    Smail.find(params[:id]).destroy
    flash[:success] = "Mail task deleted"
    redirect_to(mails_list_url)
  end

  def delay_mail
    users = User.first(3)
    id = params[:id]
    mail = Smail.find(id)
    message = mail.message
    time = mail.scheduled_at
    Delayed::Job.enqueue NewsletterJob.new(users, message), 0, time
    mail.update_attribute :enqueued, true
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
