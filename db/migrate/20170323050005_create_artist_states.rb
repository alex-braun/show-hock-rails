class CreateArtistStates < ActiveRecord::Migration
  def change
    create_table :artist_states do |t|

      t.timestamps null: false
    end
  end
end
