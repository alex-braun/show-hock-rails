class Show < ActiveRecord::Base
  has_many :users, through: :calendars
  has_many :calendars
  has_many :performers
  validates :event_id, uniqueness: true
end
