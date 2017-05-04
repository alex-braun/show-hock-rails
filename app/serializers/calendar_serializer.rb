class CalendarSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :user,
             :show,
             :show_id,
             :isDone,
             :event_id

  def user
    object.user_id
  end

  def show
    object.show_id
  end
end