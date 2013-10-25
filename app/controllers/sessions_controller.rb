class SessionsController < Devise::SessionsController

	def create
		render :json => {:birds => "ass"}
	end
end
