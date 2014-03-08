class Api::V1::SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create]
  skip_before_filter :verify_authenticity_token #, :if => Proc.new { |c| c.request.format == 'application/json' }
  before_filter :validate_auth_token, :except => :create
  include Devise::Controllers::Helpers
  include ApiHelper
  respond_to :json

  #TODO
  #REFACTOR: extract method
  after_filter :set_access_control_headers

  def set_access_control_headers
  	headers['Access-Control-Allow-Origin'] = '*'
  	headers['Access-Control-Request-Method'] = '*'
  end
  #REFACTOR: end

  def new
    render :text => "hihihi"
    return
  end

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

  def options
  	Rails.logger.info("options block")
  	headers['Access-Control-Allow-Origin'] = "*"
  	headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, OPTIONS'
  	headers['Access-Control-Max-Age'] = '100'
  	headers['Access-Control-Allow-Headers'] = '*, x-requested-with, content-type, accept, origin, referer, user-agent'
  	render :text => '', :content_type => 'text/plain'
  end

  def failure(fstr = 'api.v1.sessions.invalid_login')
    return render json: { success: false, errors: [t(fstr)] }, :status => :unauthorized
  end

end
