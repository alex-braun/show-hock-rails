class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :songkick_id
      t.string :name
      t.text :artists, array: true, default: []
      t.text :location
      t.datetime :date
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
