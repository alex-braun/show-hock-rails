class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.boolean :isDone
      t.references :event, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
