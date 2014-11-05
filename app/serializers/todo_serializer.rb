class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :order, :completed
  binding.pry
end
