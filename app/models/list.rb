class List < ActiveRecord::Base
  include IdentityCache

  belongs_to :user

  has_many :items, dependent: :destroy

  cache_has_many :items, embed: true
end
