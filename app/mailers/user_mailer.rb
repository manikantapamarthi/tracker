class UserMailer < ApplicationMailer
  default from: "manikanta@example.com"
  
  def welcome_email(user, password)
    @user = user
    @email = @user.email
    @password = password
    mail(to: @email, subject: "Welcome to Tracker")
  end
end
