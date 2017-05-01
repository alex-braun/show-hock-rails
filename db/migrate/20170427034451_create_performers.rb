class CreatePerformers < ActiveRecord::Migration
  def change
    create_table :performers do |t|
      t.integer :artist_id
      t.string :artist_name
      t.string :artist_img
      t.references :show, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
