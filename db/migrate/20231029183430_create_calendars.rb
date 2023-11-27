class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :courseName
      t.datetime :start_time
      t.datetime :end_time
      t.integer :repeated_weeks, default: 0
      t.string :location
    end
  end
end
