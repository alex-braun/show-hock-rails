class AddStartDateToShows < ActiveRecord::Migration
  def change
    add_column :shows, :start_date, :datetime
  end
end
