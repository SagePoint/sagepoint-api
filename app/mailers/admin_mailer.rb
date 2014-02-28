# Send contact email from user to SP

class AdminMailer < ActionMailer::Base
  default :from => "metrics@sagepointsoftware.com"
  after_action :log_email!

  def daily_metrics(fromEmail, toEmail, metrics_list)
    @fromEmail = fromEmail
  	@toEmail = toEmail
  	@metrics_list = metrics_list
    mail(:to => @toEmail,:subject => "Daily Metrics for #{Time.now.strftime("%D")}")    
  end

  private

    def log_email!      
      EmailLog.log_by_email!(@fromEmail,@toEmail,action_name)
    end

end