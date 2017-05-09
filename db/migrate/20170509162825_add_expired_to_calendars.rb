class AddExpiredToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :expired, :boolean, default: false
  end
end
