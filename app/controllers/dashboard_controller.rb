class DashboardController < ApplicationController
	before_filter :auth_user

  	def index
  		return render :text => "ass"
  	end
end
