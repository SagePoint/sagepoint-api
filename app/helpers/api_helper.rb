module ApiHelper

  def validate_auth_token
  	if params[:auth_token].present? then
	    resource = User.find_by_authentication_token(params[:auth_token])
	    render :status => 401, :json => {errors: [t('api.v1.token.invalid_token')]} if resource.nil?
	end

  end

end
