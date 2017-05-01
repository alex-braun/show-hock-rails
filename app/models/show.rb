class Show < ActiveRecord::Base
  has_many :users, through: :calendars
  has_many :calendars
  has_many :performers
  validates :event_id, uniqueness: { message: '' }

  # validates :id, uniqueness: true,

  # validates :id, uniqueness: { message: :id }
end
