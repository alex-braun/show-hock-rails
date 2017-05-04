class RemoveStartFromShows < ActiveRecord::Migration
  def change
    remove_column :shows, :start, :datetime
    remove_column :shows, :end, :datetime
  end
end
