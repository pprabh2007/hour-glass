# app/models/calendar.rb
class Calendar < ActiveRecord::Base
  validates :courseName, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :repeated_weeks, numericality: { greater_than_or_equal_to: 0 }
end
