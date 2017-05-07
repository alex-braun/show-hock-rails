class DropEventsTable < ActiveRecord::Migration
  def change
    drop_table :events do |t|
      t.text     :artists, default: [], array: true
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :start
      t.datetime :end
      t.string   :city
      t.string   :country
      t.string   :state
      t.string   :event_name
      t.integer  :event_id
      t.string   :venue_name
      t.integer  :venue_id
      t.string   :region_name
      t.integer  :region_id
    end
  end
end
