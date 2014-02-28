class Api::V1::PasswordsController < Devise::PasswordsController
  prepend_before_filter :require_no_authentication
#  skip_before_filter :verify_authenticity_token #, :if => Proc.new { |c| c.request.format == 'application/json' }
#  before_filter :validate_auth_token, :except => :create
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

  def update
#      User.reset_password_by_token(:attributes => {:reset_password_token => params[:reset_password_token]})
      # reset_password_token = Devise.token_generator.digest(self, :reset_password_token, params[:reset_password_token])
      # Rails.logger.info("TOKEN: #{reset_password_token}")
      # return render json: {success: false, token: params[:reset_password_token], password: params[:password]}
    self.resource = resource_class.reset_password_by_token(
      :reset_password_token => params[:reset_password_token],
      :password => params[:password],
      :password_confirmation => params[:password_confirmation])

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_flashing_format?
      sign_in(resource_name, resource)
      return render json: {success: true, message: flash_message}
    else
      return render json: {success: false, errors: resource.errors}
    end

  end

  def create
  	resource = User.find_by_email(params[:email])
  	return failure unless resource

  	raw = resource.send_reset_password_instructions
    EmailLog.log!(nil,resource,'password_reset')
  	render :json=> {:success => true, :message => "Reset instructions sent to #{resource.email}", :raw => raw}

  end

  def options
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, OPTIONS'
    headers['Access-Control-Max-Age'] = '100'
    headers['Access-Control-Allow-Headers'] = '*, x-requested-with, content-type, accept, origin, referer, user-agent'
    render :text => '', :content_type => 'text/plain'
  end

  def failure
  	return render json: { success: false, errors: [t('api.v1.passwords.invalid_account')] }, :status => :unauthorized
  end


end
