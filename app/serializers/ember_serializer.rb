class EmberSerializer < ActiveModel::Serializer
  embed :ids, include: true
end
