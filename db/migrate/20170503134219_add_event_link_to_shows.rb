class AddEventLinkToShows < ActiveRecord::Migration
  def change
    add_column :shows, :event_link, :string
  end
end
