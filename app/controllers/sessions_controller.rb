class SessionsController < ApplicationController
	skip_before_action :authorize

	def new
	end

	def create
		rp = ResourceProfile.find_by(email: params[:email])
		if !rp
			redirect_to login_url, alert: "Invalid user/password combination"
		end
		user = rp.user
		if user and user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to secure_test_url
		else
			redirect_to login_url, alert: "Invalid user/password combination"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to '/', notice: "Logged out"
	end
end