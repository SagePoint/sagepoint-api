class SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create, :new]
  skip_before_filter :verify_authenticity_token
  include Devise::Controllers::Helpers

  def create
  	resource = User.find_for_database_authentication(:email => params[:email])
  	return failure unless resource
    return failure('api.v1.sessions.disabled_employer') unless resource.employer.is_enabled

  	if resource.valid_password?(params[:password])
  		_log("Resource password correct: #{resource}")
  		_log("Checking if resource is enabled...")
  		return failure('api.v1.sessions.account_disabled') if not resource.is_enabled?
  		sign_in(:user, resource)
  		resource.ensure_authentication_token!
  		render :json=> {:success => true, :token => resource.authentication_token}
  		return
  	end
  	failure
  end

  def destroy
  	resource.reset_authentication_token!
  	Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
  	render :status => 200, :json => {}
  end

  def failure(fstr = 'api.v1.sessions.invalid_login')
  	flash[:error] = t(fstr)
  	redirect_to new_user_session_url
  end
end
