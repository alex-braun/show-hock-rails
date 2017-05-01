class AddTypeToShows < ActiveRecord::Migration
  def change
    add_column :shows, :type, :string
  end
end
