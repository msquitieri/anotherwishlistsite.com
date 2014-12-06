class ListSerializer < EmberSerializer
  attributes :id, :title, :start_date, :end_date, :user

  has_many :items
end