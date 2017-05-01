class AddIsDoneToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :isDone, :boolean, default: false
  end
end
