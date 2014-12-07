class ListSerializer < EmberSerializer
  attributes :id, :title, :start_date, :end_date, :user_id

  has_many :items
end