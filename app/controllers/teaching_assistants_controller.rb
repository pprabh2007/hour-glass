class TeachingAssistantsController < ApplicationController
  before_action :set_teaching_assistant, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user, only: [:new_office_hour, :create_office_hour]

  def new_office_hour
    @calendar = Calendar.new
  end

  def create_office_hour
    @calendar = current_user.calendars.build(calendar_params)
  
    if @calendar.save
      if @calendar.recurrence == "1"
        start_time = @calendar.start_time.advance(weeks: 1)
        end_time = @calendar.end_time.advance(weeks: 1)
        while start_time < 15.weeks.from_now(@calendar.start_time)
          new_calendar = current_user.calendars.build(
            class_id: @calendar.class_id,
            start_time: start_time,
            end_time: end_time,
            recurrence: @calendar.recurrence
          )
          new_calendar.save
          start_time = start_time.advance(weeks: 1)
          end_time = end_time.advance(weeks: 1)
        end
        redirect_to user_profile_path, notice: 'Weekly office hours were successfully added.'
      elsif @calendar.recurrence == "0"
        redirect_to user_profile_path, notice: 'Office hours were successfully added.'
      else
        redirect_to new_office_hour_teaching_assistants_path, notice: 'Failed to add office hours.'
      end
    else
      render :new_office_hour
    end
  end
  
  private

  def calendar_params
    params.require(:calendar).permit(:class_id, :start_time, :end_time, :recurrence)
  end
end
