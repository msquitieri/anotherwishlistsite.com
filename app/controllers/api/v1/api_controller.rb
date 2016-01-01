class Api::V1::ApiController < ApplicationController
  respond_to :json

  skip_before_action :verify_authenticity_token

  before_filter :set_general_access_control_headers
  before_action :authenticate_api_key

  skip_before_action :authenticate_api_key, only: :handle_options_request

  def render_message(head, status_code, message)
    render json: { head => { message: message } }, status: status_code
  end

  def handle_options_request
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-api-key, Content-Type'
    headers['Access-Control-Max-Age']       = '300'
    head :ok
  end

  private

  def set_general_access_control_headers
    # The P3P header is needed for IE to properly return
    # cookies in JSONP requests.
    headers['P3P'] = "CP='NOI ADM DEV COM NAV OUR STP'"

    headers['Access-Control-Allow-Origin'] = '*'
    # headers['Access-Control-Allow-Credentials'] = 'true'
  end

  def authenticate_api_key
    api_key = params[:api_key] || request.headers['X-api-key']
    render_message(:auth, 401, 'Invalid API key') if api_key.nil? or api_key != '1234'
  end

end