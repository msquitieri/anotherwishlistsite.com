class ItemSerializer < EmberSerializer
  attributes :id, :title, :price, :notes, :image, :link, :quantity, :priority, :reserved, :list_id
end