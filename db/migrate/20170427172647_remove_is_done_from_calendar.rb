class RemoveIsDoneFromCalendar < ActiveRecord::Migration
  def change
    remove_column :calendars, :isDone, :boolean
  end
end
