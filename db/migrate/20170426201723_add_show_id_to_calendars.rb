class AddShowIdToCalendars < ActiveRecord::Migration
  def change
    add_reference :calendars, :show, index: true, foreign_key: true
  end
end
