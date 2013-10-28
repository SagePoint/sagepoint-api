class Api::V1::SecureController < ApplicationController

  include Devise::Controllers::Helpers
  include ApiHelper

  before_filter :authenticate_user

  def index
  	render :json => {:yay => "You're in !", :session => session}
  end
end
