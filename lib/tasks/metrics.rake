#require "#{Rails.root}/app/helpers/skill_helper"
namespace :metrics do
	#TODO add digests emails per employer. 
	desc 'Send daily metrics mail'
	task :daily => :environment do
		puts "Sending daily metrics email\n"
		begin
			admin_mailing_list = ["nzitsman@sagepointsoftware.com"] #["nzitsman@sagepointsoftware.com","richard@sagepointsoftware.com","jarad@sagepointsoftware.com"]
			metrics = []

      #metrics << ["Errors Caught",0] #Trap through errbit
      metrics << ["User Type Counts",""]
      UserType.joins(:users).order("code").group(:code).count.each{|a,b| 
        metrics << [a,b]
      }
      metrics << ["",""]
			metrics << ["Total Users",User.count]
			metrics << ["Enabled Users",User.enabled.count]
      metrics << ["Active Users (6mo)",User.enabled.active.count]
			metrics << ["Daily Active Users (24 hr)",User.enabled.daily_active.count]
      metrics << ["",""]
      #TODO fill these in
      metrics << ["Daily Emails Sent",EmailLog.past_day.count]
      metrics << ["Emails by Type",""]
      EmailLog.past_day.group(:message_type).count.each{|a,b| 
        metrics << [a,b]
      }
      metrics << ["",""]
      # projects created that day
      metrics << ["Daily Projects Created",Project.past_day.count]
      # tasks created that day
      metrics << ["Daily Tasks Created",Task.past_day.count]    
      metrics << ["Daily Resource Requests",ResourceRequest.past_day.count]
      metrics << ["Daily Resource Requests Approved",ResourceRequest.approved_past_day.count]
      # resource assignments made that day
      metrics << ["",""]
      metrics << ["Users by Employer",""]
      UserType.joins(:users=>[:employer]).order("name").group(:name).count.each{|a,b| 
        metrics << [a,b]
      }


      admin_mailing_list.each do |admin_email|
			 AdminMailer.daily_metrics('metrics@sagepointsoftware.com', admin_email, metrics).deliver
      end
		rescue Exception => e
			puts "Error: #{e.message}\n"
		end
		puts "Complete\n"
	end
end

