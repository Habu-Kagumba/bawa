class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save ? new_user(@user) : (render "new")
  end

  def check_email
    render json: !User.exists?(email: params[:user][:email])
  end

  def check_username
    render json: !User.exists?(username: params[:user][:username])
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end

  def user_auth(user)
    UserAuthenticator.new(user, session, cookies)
  end

  def new_user(user)
    UserMailer.welcome_email(user).deliver_later
    user_auth(user).login
    flash[:success] = "Successfully created your account. Welcome to Bawa."
    redirect_on_login root_path
  end
end
