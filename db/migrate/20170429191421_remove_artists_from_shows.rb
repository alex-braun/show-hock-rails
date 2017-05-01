class RemoveArtistsFromShows < ActiveRecord::Migration
  def change
    remove_column :shows, :artists, :text
  end
end
