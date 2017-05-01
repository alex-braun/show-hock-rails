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
             :calendars,
             :type

  def users
    # object.users.select([:id, :email]).map { |e| { id: e.id, email: e.email } }

    object.users.pluck(:id, :email).map { |e| { id: e[0], email: e[1] } }
    # object.users.pluck(:id, :email)
  end

  def calendars
    object.calendars.pluck(:id)
  end
end
# pluck(:first, :last, :dob).map {|e| {first: e[0], last: e[1], dob: e[2]} }
