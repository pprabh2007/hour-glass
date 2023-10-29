class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :courseId
      t.datetime :startTime
      t.datetime :endTime
    end
  end
end
