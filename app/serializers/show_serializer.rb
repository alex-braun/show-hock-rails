class ShowSerializer < ActiveModel::Serializer
  attributes :id,
             :performers,
             :region_id,
             :region_name,
             :venue_id,
             :venue_name,
             :event_id,
             :event_name,
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
