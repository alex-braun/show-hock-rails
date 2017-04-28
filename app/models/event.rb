class Event < ActiveRecord::Base
  has_many :users, through: :calendars
  has_many :calendars
  validates :event_id, uniqueness: true
end
