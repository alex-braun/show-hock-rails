class AddEventIdToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :event_id, :integer
  end
end
