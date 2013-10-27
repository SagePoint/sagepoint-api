module ApiHelper

	def validate_auth_token
		resource = User.find_by_authentication_token(params[:auth_token])
		return invalid_token if resource.nil?
		sign_in(:user, resource)
		return true
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

	def authenticate_user
		_log("Called 'authenticate_user")
		return if api_v1_user_signed_in?

		return validate_auth_token if params[:auth_token].present?

		return unauthorized if not api_v1_user_signed_in?
	end

	def _log(msg, type='info')
		Rails.logger.send("#{type}","API: #{msg}")
	end

end
