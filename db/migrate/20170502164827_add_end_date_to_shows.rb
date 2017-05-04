class AddEndDateToShows < ActiveRecord::Migration
  def change
    add_column :shows, :end_date, :datetime
  end
end
