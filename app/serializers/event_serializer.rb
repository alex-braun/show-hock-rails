class EventSerializer < ActiveModel::Serializer
  attributes :id, :songkick_id, :name, :artists, :location, :date
  has_one :user
end
