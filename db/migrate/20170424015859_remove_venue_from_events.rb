class RemoveVenueFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :venue
  end
end
