class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :reset_session
    respond_to :json

	before_filter :set_access_control_headers

	def set_access_control_headers
		response.headers['Access-Control-Allow-Origin'] = '*'
		response.headers["Access-Control-Allow-Headers"] = "Content-Type, X-Requested-With"
		response.headers['Access-Control-Request-Method'] = 'GET, PUT, POST, DELETE, OPTIONS'
	end
end
