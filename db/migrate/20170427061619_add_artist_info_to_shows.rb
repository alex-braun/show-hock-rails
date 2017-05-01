class AddArtistInfoToShows < ActiveRecord::Migration
  def change
    add_column :shows, :artist_id, :integer
    add_column :shows, :artist_name, :string
    add_column :shows, :artist_img, :string
  end
end
