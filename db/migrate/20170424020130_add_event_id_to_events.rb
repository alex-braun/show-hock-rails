class AddEventIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_id, :integer
  end
end
