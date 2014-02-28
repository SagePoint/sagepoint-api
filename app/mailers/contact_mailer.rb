# Send contact email from user to SP

class ContactMailer < ActionMailer::Base
  default :from => "no-reply@sagepointsoftware.com"
  after_action :log_email!

  def customer_inquiry(fromEmail, toEmail, body)
  	@fromEmail = fromEmail
    @toEmail = toEmail
  	@body = body
    mail(:to => @toEmail,:subject => 'Customer Inquiry')
  end

  private

    def log_email!      
      EmailLog.log_by_email!(@fromEmail,@toEmail,action_name)
    end
end