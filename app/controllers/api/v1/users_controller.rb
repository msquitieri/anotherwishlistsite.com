class Api::V1::ListsController < Api::V1::ResourceController

  private

  def resource
    User
  end

  def permit_params
    [:email, :first_name, :last_name]
  end

end