class Api::V1::PasswordsController < Devise::PasswordsController

#  prepend_before_filter :require_no_authentication, :only => [:create]
#  skip_before_filter :verify_authenticity_token #, :if => Proc.new { |c| c.request.format == 'application/json' }
#  before_filter :validate_auth_token, :except => :create
  include Devise::Controllers::Helpers
  include ApiHelper
  respond_to :json

  #TODO
  #REFACTOR: extract method
  after_filter :set_access_control_headers

  def set_access_control_headers
	Rails.logger.info("SETTING HEADERS")
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'origin, x-requested-with, content-type, accept, authorization'
  end
  #REFACTOR: end

  def create
	Rails.logger.info("hihihi")
  	resource = User.find_by_email(params[:email])
  	return failure unless resource

#  	resource.send_reset_password_instructions
  	render :json=> {:success => true, :message => "Reset instructions sent to #{resource.email}"}

  end

  def failure
  	return render json: { success: false, errors: [t('api.v1.passwords.invalid_account')] }, :status => :unauthorized
  end


end
