class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :artists,
             :artist_id,
             :artist_name,
             :artist_img,
             :region_id,
             :region_name,
             :venue_id,
             :venue_name,
             :event_name,
             :event_id,
             :start,
             :end,
             :city,
             :state,
             :country,
             :users,
             :calendars

  def users
    object.users.pluck(:id)
  end

  def calendars
    object.calendars.pluck(:id)
  end
end
