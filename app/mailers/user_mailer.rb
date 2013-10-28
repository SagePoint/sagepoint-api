# Send password reset notification
# path: app/mailers/user_mailer.rb
class UserMailer < ActionMailer::Base
  default :from => "no-reply@sagepointsoftware.com"

  def password_reset(user, password)
    @user = user
    @password = password
    mail(:to => user.email,
         :subject => 'Password Reset Notification')
  end
end