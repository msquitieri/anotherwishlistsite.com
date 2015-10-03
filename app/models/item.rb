class Item < ActiveRecord::Base
  include IdentityCache

  belongs_to :list, touch: true
end
