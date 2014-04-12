class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :reset_session

    helper_method :core_mailing_list
  	after_filter :set_access_control_headers

	def auth_user
		_log("Called 'auth_user")
		_log("Session: #{session.inspect}")
		return true if user_signed_in?
		_log("User not logged in")
		_log("Redirecting to Login page")
		redirect_to new_user_session_url
	end

	def set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Request-Method'] = '*'
	end


	def options
		headers['Access-Control-Allow-Origin'] = "*"
		headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, OPTIONS'
		headers['Access-Control-Max-Age'] = '100'
		headers['Access-Control-Allow-Headers'] = '*, x-requested-with, content-type, accept, origin, referer, user-agent'
		render :text => '', :content_type => 'text/plain'
	end

    def core_mailing_list
    	[
			'jdelorenzo@sagepointsoftware.com',
			'nzitsman@sagepointsoftware.com',
			'rwilner@sagepointsoftware.com'
		].join(',')
    end

	def _log(msg, type='info')
		Rails.logger.send("#{type}","APPLICATION: #{msg}")
	end
end
