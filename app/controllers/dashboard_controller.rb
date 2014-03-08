class DashboardController < ApplicationController
	before_filter :authenticate_user!
  	include Devise::Controllers::Helpers

  	def index
  	end
end
