class CreateVenueCalendars < ActiveRecord::Migration
  def change
    create_table :venue_calendars do |t|

      t.timestamps null: false
    end
  end
end
