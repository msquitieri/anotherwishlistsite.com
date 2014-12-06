class Api::V1::ListsController < Api::V1::ResourceController

  private

  def resource
    List
  end

  def permit_params
    [:title, :start_date, :end_date, :user_id]
  end

end