class SessionsController < ApplicationController
  def new
  end

  def create
    user_auth.create_session(params[:session])
    logged_in? ? successful_login : failed_login
  end

  def destroy
    user_auth.logout if logged_in?
    redirect_to login_path
  end

  def check_username_email
    render json: found
  end

  private

  def user_auth
    UserAuthenticator.new(current_user, session, cookies)
  end

  def successful_login
    flash[:success] = "Successfully logged in"
    redirect_on_login root_path
  end

  def failed_login
    flash.now[:error] = "Invalid email/username and password combination"
    render "new"
  end

  def found
    user_auth.get_user(params[:session][:email_username]) ? true : false
  end
end
