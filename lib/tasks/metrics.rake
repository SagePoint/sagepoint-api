#require "#{Rails.root}/app/helpers/skill_helper"
namespace :metrics do
	#TODO add digests emails per employer. 
	desc 'Send daily metrics mail'
	task :daily => :environment do
		puts "Sending daily metrics email\n"
		begin
			admin_mailing_list = ["nzitsman@sagepointsoftware.com"] #["nzitsman@sagepointsoftware.com","richard@sagepointsoftware.com","jarad@sagepointsoftware.com"]
			metrics = []

			metrics << ["Total Users",User.count]
			metrics << ["Enabled Users",User.enabled.count]
      metrics << ["Active Users (6mo)",User.enabled.active.count]
			metrics << ["Daily Active Users (24 hr)",User.enabled.daily_active.count]

      #TODO fill these in
      metrics << ["Daily Emails Sent",EmailLog.past_day.count]
      EmailLog.past_day.group(:message_type).count.each{|a,b| 
        metrics << ["Email Type:"+a,b]
      }
      metrics << ["Errors Caught",0]



      admin_mailing_list.each do |admin_email|
			 AdminMailer.daily_metrics('metrics@sagepointsoftware.com', admin_email, metrics).deliver
      end
		rescue Exception => e
			puts "Error: #{e.message}\n"
		end
		puts "Complete\n"
	end
end

