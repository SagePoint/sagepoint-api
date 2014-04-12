require "#{Rails.root}/app/helpers/skill_helper"
namespace :skills do
	include SkillHelper
	desc 'List groups of similar tasks'
	task :similar => :environment do
		model = ENV['MODEL'] || 'Skill'
		groups = Array.new
		begin
			model = model.constantize
			skills = model.find(:all)
			idx = skills.size-1
			for outter in idx.downto(1)
				puts "Outter(#{outter}) grouped?: #{!skills[outter].instance_variable_get(:@grouped).nil?} | #{skills[outter].skill_desc}"
				next if skills[outter].instance_variable_get(:@grouped) || !skills[outter].verified.nil?
				set = Set.new [outter]
				for inner in 0..outter-1
					# puts "--->Inner(#{inner}) grouped?: #{!skills[inner].instance_variable_get(:@grouped).nil?}"
					next if skills[inner].instance_variable_get(:@grouped) || !skills[inner].verified.nil?
					# puts "-------> #{skills[outter].skill_desc} [:::] #{skills[inner].skill_desc}"
					# puts "#{outter} ::: #{inner}"
					groupIfSimilar(skills, outter, inner, set)
					groupIfSimilarButMissingPrefix(skills, outter, inner, set) # Microsoft Windows -> Windows
				end
				if(set.length > 1)
					set.each do |s|
						puts skills[s].skill_desc
					end
					skills[outter].verified = 0
					skills[outter].save
				end
				puts "---------------- END GROUP #{groups.length} ------------------"
				groups.push(set)
			end
			puts "<<<-------------- REPORT -------------->>>"
			puts "<<< #{groups.length} groups to review  >>>"
		rescue Exception => e
			puts "Error: #{e.message}"
		end
	end
end

namespace :skills do
	include SkillHelper
	include ActionView::Helpers::DateHelper
	desc 'List groups of similar tasks'
	task :similar_past_day => :environment do
		hours = 24
		puts "Calculating similar skills added since #{time_ago_in_words(hours.hours.ago)} ago..."
		begin
			model = "Skill".constantize
			new_skills = model.find(:all, :conditions => ["created_at > ? AND verified IS NULL", hours.hours.ago])
			skills = model.find(:all)
			puts "#{new_skills.length} were added in the past #{time_ago_in_words(hours.hours.ago)}"
			new_skills.each do |ns|
					ns.verified = 0
					ns.save
				end
		rescue Exception => e
			puts "Error: #{e.message}"
		end
	end
end

namespace :skills do
	include SkillHelper
	desc 'Break skill descriptions into metadata and insert into metadata table'
	task :index => :environment do
		puts "THIS WILL ERASE ALL METADATA! Type: 'BALLS' to continue"
		confirm = $stdin.gets.chomp
		if confirm == "BALLS"
			model = ENV['MODEL'] || 'Skill'
			begin
				model = model.constantize
				skills = model.find(:all, :limit=>10)
				skills.each_with_index do |s, i|
					skillDescToMetadata(s)
				end
			rescue Exception => e
				puts "Error: #{e.message}"
			end
		end
	end
end



