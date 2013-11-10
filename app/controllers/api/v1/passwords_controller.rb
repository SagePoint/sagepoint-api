class Api::V1::PasswordsController < Devise::PasswordsController

#  prepend_before_filter :require_no_authentication, :only => [:create]
#  skip_before_filter :verify_authenticity_token #, :if => Proc.new { |c| c.request.format == 'application/json' }
#  before_filter :validate_auth_token, :except => :create
  include Devise::Controllers::Helpers
  include ApiHelper
  respond_to :json

  def update
#      User.reset_password_by_token(:attributes => {:reset_password_token => params[:reset_password_token]})
      reset_password_token = Devise.token_generator.digest(self, :reset_password_token, params[:reset_password_token])
      Rails.logger.info("TOKEN: #{reset_password_token}")
      return render json: {success: false, token: params[:reset_password_token], password: params[:password]}
  end

  def create
  	resource = User.find_by_email(params[:email])
  	return failure unless resource

  	resource.send_reset_password_instructions
  	render :json=> {:success => true, :message => "Reset instructions sent to #{resource.email}"}

  end

  def failure
  	return render json: { success: false, errors: [t('api.v1.passwords.invalid_account')] }, :status => :unauthorized
  end


end
