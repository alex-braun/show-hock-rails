class CreateArtistSearches < ActiveRecord::Migration
  def change
    create_table :artist_searches do |t|

      t.timestamps null: false
    end
  end
end
