class AddRegionNameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :region_name, :string
  end
end
