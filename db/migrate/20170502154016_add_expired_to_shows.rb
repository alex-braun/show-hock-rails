class AddExpiredToShows < ActiveRecord::Migration
  def change
    add_column :shows, :expired, :boolean, default: false
  end
end
