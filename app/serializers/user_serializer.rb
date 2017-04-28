# frozen_string_literal: true
class UserSerializer < ActiveModel::Serializer
  # admin attr needs to be placed here!
  attributes :id, :email, :shows, :calendars
  # attributes :id, :email
  def shows
    object.shows.pluck(:id)
  end

  def calendars
    object.calendars.pluck(:id)
  end
end
