class Api::V1::SkillsController < ApplicationController
  	include Devise::Controllers::Helpers
	include ApiHelper
	respond_to :json
  	before_filter :authenticate_user

	def index
		@skills = Skill.find(:all)
	  	render :json => @skills.to_json
	end

	def show
		render :json => {:success => false, :msg => "Not yet implemented" }
	end
end
