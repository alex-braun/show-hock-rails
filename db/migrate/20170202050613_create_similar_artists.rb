class CreateSimilarArtists < ActiveRecord::Migration
  def change
    create_table :similar_artists do |t|

      t.timestamps null: false
    end
  end
end
