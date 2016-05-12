class UserMailer < ApplicationMailer
  default from: "no-reply@bawa.com"

  def welcome_email(user)
    @user = user
    @url = "https://bawa.herokuapp.com/login"
    mail(to: @user.email, subject: "Welcome to Bawa")
  end
end
