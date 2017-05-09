class CalendarSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :user,
             :show,
             :show_id,
             :is_done,
             :event_id,
             :end_date,
             :expired
            #  :start_date

  def user
    object.user_id
  end

  def show
    object.show_id
  end
end
