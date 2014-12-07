class ItemSerializer < EmberSerializer
  attributes :id, :title, :price, :notes, :image, :link, :quantity, :priority, :list_id
end