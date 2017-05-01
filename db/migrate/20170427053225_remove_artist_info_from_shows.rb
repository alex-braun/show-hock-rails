class RemoveArtistInfoFromShows < ActiveRecord::Migration
  def change
    remove_column :shows, :artist_id, :integer
    remove_column :shows, :artist_name, :string
    remove_column :shows, :artist_img, :string
  end
end
