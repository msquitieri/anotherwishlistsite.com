class UserSerializer < EmberSerializer
  attributes :id, :email, :first_name, :last_name

  has_many :lists
end