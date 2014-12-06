class ListSerializer < EmberSerializer
  attributes :id, :title, :start_date, :end_date

  belongs_to :list
end