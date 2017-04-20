class CreateLocationGeos < ActiveRecord::Migration
  def change
    create_table :location_geos do |t|

      t.timestamps null: false
    end
  end
end
