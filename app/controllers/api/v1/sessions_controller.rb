class Api::V1::SessionsController < Api::V1::ApiController
  respond_to :json

  before_action :set_user, only: [:create]

  attr_accessor :user

  def create
    sign_in user
    respond_with user
  end

  def destroy
    sign_out :user
    render json: {}, status: :accepted
  end

  def current
    if current_user.present?
      respond_with current_user
    else
      render json: {}
    end
  end

  private

  def set_user
    @user = User.find_for_database_authentication(email: params[:session][:email])

    unless user && user.valid_password?(params[:session][:password])
      render_message(:session, "Invalid Email or Password", 422)
    end
  end

end