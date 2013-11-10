class Api::V1::PasswordsController < Devise::PasswordsController
  prepend_before_filter :require_no_authentication
#  skip_before_filter :verify_authenticity_token #, :if => Proc.new { |c| c.request.format == 'application/json' }
#  before_filter :validate_auth_token, :except => :create
  include Devise::Controllers::Helpers
  include ApiHelper
  respond_to :json

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
      respond_with resource, :location => after_resetting_password_path_for(resource)
    else
      respond_with resource
    end

  end

  def create
  	resource = User.find_by_email(params[:email])
  	return failure unless resource

  	raw = resource.send_reset_password_instructions
  	render :json=> {:success => true, :message => "Reset instructions sent to #{resource.email}", :raw => raw}

  end

  def failure
  	return render json: { success: false, errors: [t('api.v1.passwords.invalid_account')] }, :status => :unauthorized
  end


end
