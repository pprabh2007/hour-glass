class Calendar < ActiveRecord::Base

  validates :courseName, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :recurrence, inclusion: { in: %w(0 1) }
end
