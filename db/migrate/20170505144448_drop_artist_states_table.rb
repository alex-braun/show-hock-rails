class DropArtistStatesTable < ActiveRecord::Migration
  def change
    drop_table :artist_states do |t|
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
