class AddIsDoneToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :is_done, :boolean, default: false
  end
end
