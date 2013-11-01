class Api::V1::SecureController < ApplicationController

  include Devise::Controllers::Helpers
  include ApiHelper

  before_filter :validate_auth_token
  before_filter :authenticate_api_v1_user!

  respond_to :json

  def index
  	render :json => {:yay => "You're in !"}
  end
end
