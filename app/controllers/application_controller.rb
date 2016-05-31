class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def redirect_on_login(where)
    redirect_to(session[:url] || where)
    session.delete(:url)
  end

  def store_url
    session[:url] = request.fullpath
  end

  def logged_in_user
    unless logged_in?
      store_url
      flash[:error] = "Please log in to continue"
      redirect_to login_url
    end
  end
end
