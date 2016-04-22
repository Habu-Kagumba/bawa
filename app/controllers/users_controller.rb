class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Successfully created your account. Welcome to Bawa."
      redirect_to @user
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

  def destroy
  end

  def check_email
    @user = User.find_by_email(params[:user][:email])

    respond_to do |format|
      format.json { render json: !@user }
    end
  end

  def check_username
    @user = User.find_by(username: params[:user][:username])

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
end
