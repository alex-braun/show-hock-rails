class RemoveLocationIdFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :location_id
  end
end
