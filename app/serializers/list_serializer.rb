class ListSerializer < EmberSerializer
  attributes :id, :title, :start_date, :end_date

  belongs_to :user
  has_many   :items
end