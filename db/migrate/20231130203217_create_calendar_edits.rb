class CreateCalendarEdits < ActiveRecord::Migration
  def change
    create_table :calendar_edits do |t|
      t.string :courseName
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.integer :user_id
      t.integer :edit_type
      t.datetime :update_time
    end
  end
end
