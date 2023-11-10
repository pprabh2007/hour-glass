class Calendar < ActiveRecord::Base

  validates :class_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :recurrence, inclusion: { in: %w(0 1) }
end
