class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :reset_session
  	before_filter :authenticate_user!
    respond_to :json

end
