class CreateRegionSearches < ActiveRecord::Migration
  def change
    create_table :region_searches do |t|

      t.timestamps null: false
    end
  end
end
