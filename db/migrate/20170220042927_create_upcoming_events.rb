class CreateUpcomingEvents < ActiveRecord::Migration
  def change
    create_table :upcoming_events do |t|

      t.timestamps null: false
    end
  end
end
