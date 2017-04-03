class CreateVenueSearches < ActiveRecord::Migration
  def change
    create_table :venue_searches do |t|

      t.timestamps null: false
    end
  end
end
