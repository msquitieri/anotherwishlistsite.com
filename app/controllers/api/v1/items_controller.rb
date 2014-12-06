class Api::V1::ItemsController < Api::V1::ResourceController

  private

  def resource
    Item
  end

  def permit_params
    [:title, :price, :notes, :image, :link, :quantity, :priority, :list_id]
  end

end