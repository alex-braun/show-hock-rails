class ShowSerializer < ActiveModel::Serializer
  attributes :id,
             :performers,
             :region_id,
             :region_name,
             :venue_id,
             :venue_name,
             :event_id,
             :event_name,
             :event_link,
             :city,
             :state,
             :country,
             :users,
             :calendars,
             :type,
             :expired,
             :end_date,
             :start_date

  def users
    object.users.pluck(:id, :email).map { |e| { id: e[0], email: e[1] } }
  end

  def calendars
    object.calendars.pluck(:id)
  end
end
