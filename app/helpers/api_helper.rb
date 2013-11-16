module ApiHelper

	def authenticate_user
		_log("Called 'authenticate_user")
		_log("Session: #{session.inspect}")
		return true if api_v1_user_signed_in?
		_log("User not logged in")
		_log("Checking for auth token")
		return validate_auth_token if params[:auth_token].present?

		return unauthorized if not api_v1_user_signed_in?
	end

	def _log(msg, type='info')
		Rails.logger.send("#{type}","API: #{msg}")
	end


# API JSON Error Responses
	def missing_email
		return render json: { success: false, errors: [t('api.v1.token.missing_email')] }, :status => :unauthorized
	end

	def token_email_mismatch
		return render json: { success: false, errors: [t('api.v1.token.token_email_mismatch')] }, :status => :unauthorized
	end

	def invalid_token
		return render json: { success: false, errors: [t('api.v1.token.invalid_token')] }, :status => :unauthorized
	end

	def unauthorized
		return render json: { success: false, errors: [t('api.v1.unauthorized')] }, :status => :unauthorized
	end

	def unprivileged
		return render json: { success: false, errors: [t('api.v1.unprivileged')] }, :status => :unauthorized
	end


protected

	def validate_auth_token
		return missing_email unless params[:email]
		resource = User.find_by_authentication_token(params[:auth_token])
		return invalid_token if resource.nil?
		return token_email_mismatch unless params[:email].eql?(resource.email)
		_log("Auth token present and valid - signing in user")
		sign_in(:user, resource)
		return true
	end

end
