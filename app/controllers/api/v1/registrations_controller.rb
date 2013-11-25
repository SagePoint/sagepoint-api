class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_filter :validate_auth_token
  skip_before_filter :authenticate_scope!

  respond_to :json
  include ApiHelper

  #TODO
  #REFACTOR: extract method
  after_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  # GET /resource/sign_up
  def new
    _log("NEW")
    build_resource({})
    respond_with self.resource
  end

  # POST /resource
  def create
    _log("CREATE")
    build_resource(sign_up_params)

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    _log("EDIT")
    render :edit
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    _log("UPDATE")
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    acc_params = params[:user]
    acc_params.permit(:current_password, :password, :password_confirmation)
    if update_resource(resource, acc_params)
      sign_in resource_name, resource, :bypass => true
      return render :json => {:success => true}
    else
      clean_up_passwords resource
      return failure
    end
  end

  # DELETE /resource
  def destroy
    _log("DESTROY")
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    _log("CANCEL")
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  def update_password
    _log("UPDATE_PASSWORD")
    return failure('api.v1.registrations.missing_parameter') unless params[:user] && params[:user][:password] && params[:user][:password_confirmation]
    return failure('api.v1.registrations.passwords_dont_match') unless params[:user] && params[:user][:password].eql?(params[:user][:password_confirmation])
    resource = current_user
    if resource.reset_password!(params[:user][:password], params[:user][:password_confirmation]) then
      resource.save
      return render :json => {"success" => true}
    else
      return failure(nil)
    end
  end

  def options
    _log("OPTIONS")
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, OPTIONS'
    headers['Access-Control-Max-Age'] = '100'
    headers['Access-Control-Allow-Headers'] = '*, x-requested-with, content-type, accept, origin, referer, user-agent'
    render :text => '', :content_type => 'text/plain'
  end


  protected

  def update_needs_confirmation?(resource, previous)
    _log("update_needs_confirmation()")
    resource.respond_to?(:pending_reconfirmation?) &&
      resource.pending_reconfirmation? &&
      previous != resource.unconfirmed_email
  end

  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    _log("update_resource(): #{params}")
    resource.update_with_password(params)
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    _log("build_resource()")
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    _log("sign_up()")
    sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    _log("after_sign_up_path_for()")
    after_sign_in_path_for(resource)
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    _log("after_inactive_sign_up_path_for()")
    respond_to?(:root_path) ? root_path : "/"
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    _log("after_update_path_for()")
    signed_in_root_path(resource)
  end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    _log("authenticate_scope(): #{resource_name}")
#    send(:"authenticate_#{resource_name}!", :force => true)
    send(:"validate_auth_token")
    return failure nil unless params[:email]
    self.resource = User.find_for_database_authentication
    _log(resource.email)
    return failure nil unless self.resource
  end

  def sign_up_params
    _log("sign_up_params()")
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def account_update_params
    _log("account_update_params()")
    #devise_parameter_sanitizer.sanitize(:account_update)
  end

  def failure(errString)
    errString ||= 'api.v1.registrations.generic_error'
    return render json: { success: false, errors: [t(errString)] }, :status => :unauthorized
  end
end
