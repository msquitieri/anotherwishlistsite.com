class Api::V1::SessionsController < Api::V1::ApiController
  respond_to :json

  before_action :set_user, only: [:create]

  attr_accessor :user

  def create
    sign_in user
    render json: { id: user.id, email: user.email }
  end

  def destroy
    sign_out :user
    render nothing: true, status: :accepted
  end

  def current
    if current_user.present?
      render json: { user: { id: current_user.id, email: current_user.email } }
      # respond_with current_user
    else
      render_message(:session, 200, "No current user session.")
    end
  end

  private

  def set_user
    @user = User.find_for_database_authentication(email: params[:session][:email])

    unless user && user.valid_password?(params[:session][:password])
      render_message(:session, 422, "Invalid Email or Password")
    end
  end

end