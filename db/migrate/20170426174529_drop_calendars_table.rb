class DropCalendarsTable < ActiveRecord::Migration
  def up
    drop_table :calendars do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :isDone, default: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
