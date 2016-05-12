class SessionsController < ApplicationController
  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def new
  end

  def create
    user = get_user(params[:session][:email_username])

    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Successfully logged in"
      log_in(user)
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_on_login root_path
    else
      flash.now[:error] = "Invalid email/username and password combination"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  def check_username_email
    @user = get_user(params[:session][:email_username])
    res = @user ? true : false

    respond_to do |format|
      format.json { render json: res }
    end
  end

  private

  def get_user(user_email)
    if EMAIL_REGEX.match(user_email)
      User.find_by_email(user_email)
    else
      User.find_by_username(user_email)
    end
  end
end
