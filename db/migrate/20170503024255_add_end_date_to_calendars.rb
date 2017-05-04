class AddEndDateToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :end_date, :datetime
  end
end
