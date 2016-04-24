class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = "Successfully created your account. Welcome to Bawa."
      redirect_on_login @user
    else
      render "new"
    end
  end

  def show
    @user = User.friendly.find(params[:id])
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    @user = User.friendly.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Profile successfully updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
  end

  def check_email
    @user = User.find_by_email(params[:user][:email])

    respond_to do |format|
      format.json { render json: !@user }
    end
  end

  def check_username
    @user = User.find_by_username(params[:user][:username])

    respond_to do |format|
      format.json { render json: !@user }
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :username, :email, :password,
      :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_url
      flash[:error] = "Please log in to continue"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.friendly.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
