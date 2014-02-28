# Send password reset notification
# path: app/mailers/user_mailer.rb
class UserMailer < ActionMailer::Base
  default :from => "no-reply@sagepointsoftware.com"
  after_action :log_email!

  def password_reset(user, password)
    @user = user
    @password = password
    mail(:to => user.email,
         :subject => 'Password Reset Notification')
  end
  private

    def log_email!      
      EmailLog.log!(nil,@user,action_name)
    end
end