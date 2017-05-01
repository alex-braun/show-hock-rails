class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.text :artists, array: true, default: []
      t.integer :region_id
      t.string :region_name
      t.integer :venue_id
      t.string :venue_name
      t.integer :event_id
      t.string :event_name
      t.datetime :start
      t.datetime :end
      t.string :city
      t.string :state
      t.string :country

      t.timestamps null: false
    end
  end
end
