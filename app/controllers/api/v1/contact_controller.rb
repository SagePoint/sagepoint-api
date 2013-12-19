class Api::V1::ContactController < ApplicationController
  include ApiHelper
  respond_to :json

  def create
  	fromEmail = params["fromEmail"] || "[Empty]"
    body = params["body"] || "[Empty]"
    ContactMailer.customer_inquiry(fromEmail, core_mailing_list, body).deliver
  	render :json=> {:success => true, :message => t('api.v1.contact.customer_inquiry_email_sent')}
  end

end
