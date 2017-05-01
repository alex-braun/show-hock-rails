class RemoveEventIdFromCalendars < ActiveRecord::Migration
  def change
    remove_column :calendars, :event_id
  end
end
