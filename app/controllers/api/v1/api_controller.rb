class Api::V1::ApiController < ApplicationController
  respond_to :json

  skip_before_action :verify_authenticity_token

  before_action :authenticate_api_key

  def render_message(head, status_code, message)
    render json: { head => { message: message } }, status: status_code
  end

  private

  def authenticate_api_key
    api_key = params[:api_key] || request.headers['X-api-key']
    render_message(:auth, 401, 'Invalid API key') if api_key.nil? or api_key != '1234'
  end

end