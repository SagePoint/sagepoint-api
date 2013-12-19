# Send contact email from user to SP

class ContactMailer < ActionMailer::Base
  default :from => "no-reply@sagepointsoftware.com"

  def customer_inquiry(fromEmail, toEmail, body)
  	@fromEmail = fromEmail
  	@body = body
    mail(:to => toEmail,:subject => 'Customer Inquiry')
  end
end