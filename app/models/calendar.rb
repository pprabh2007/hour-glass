# app/models/calendar.rb
class Calendar < ActiveRecord::Base
    belongs_to :teaching_assistant
  
    validates :class_id, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
  end
  