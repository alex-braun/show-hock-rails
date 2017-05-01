class RemoveSongkickIdFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :songkick_id
  end
end
