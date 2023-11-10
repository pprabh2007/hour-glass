class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :class_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :teaching_assistant_id
      t.string :recurrence, default: 'one_time'
    end
  end
end
