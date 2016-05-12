class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.welcome_email(@user).deliver_later
      log_in @user
      flash[:success] = "Successfully created your account. Welcome to Bawa."
      redirect_on_login root_path
    else
      render "new"
    end
  end

  def check_email
    exists = User.exists?(email: params[:user][:email])

    respond_to do |format|
      format.json { render json: !exists }
    end
  end

  def check_username
    exists = User.exists?(username: params[:user][:username])

    respond_to do |format|
      format.json { render json: !exists }
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :username, :email, :password,
      :password_confirmation)
  end
end
