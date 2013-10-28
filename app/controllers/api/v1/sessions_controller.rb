class Api::V1::SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create]
  skip_before_filter :verify_authenticity_token #, :if => Proc.new { |c| c.request.format == 'application/json' }
  before_filter :validate_auth_token, :except => :create
  include Devise::Controllers::Helpers
  include ApiHelper
  respond_to :json

  def create
    resource = User.find_for_database_authentication(:email => params[:email])
    return failure unless resource

    if resource.valid_password?(params[:password])
      _log("Resource: #{resource}")
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

  def failure
    return render json: { success: false, errors: [t('api.v1.sessions.invalid_login')] }, :status => :unauthorized
  end

end
