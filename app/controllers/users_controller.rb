class UsersController < ApplicationController
  before_action :is_admin, only: [:index]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update]
  skip_before_action :verify_authenticity_token
  helper_method :sort_column, :sort_direction
  def index
    @title = "Users"
    @users = User.search_name(params[:search_name]).search_email(params[:search_email]).
        search_phones(params[:search_phones]).search_phone02(params[:search_phone02]).
        order("#{sort_column} #{sort_direction}").page(params[:page]).per_page(20)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.js
    end
  end

  def new
    @title = "SignUp"
    @user = User.new
  end

  def show
    @title = "Profile"
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # log_in @user
      # flash[:success] = "Welcome to the User Control App!"
      # redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'show'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :phones, :phone02, :address, :photo_file, :search)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) || current_user.admin?
  end

  def is_admin
    redirect_to(root_url) unless current_user.admin?
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
