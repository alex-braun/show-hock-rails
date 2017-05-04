class Calendar < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id, inverse_of: :calendars
  belongs_to :show, foreign_key: :show_id, inverse_of: :calendars
  validates :user_id, uniqueness: { scope: :show_id }
end
