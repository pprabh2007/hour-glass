class TeachingAssistantsController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user, only: [:new_office_hour, :create_office_hour]

  def new_office_hour
    @your_classes = Entitlement.where({uni: session[:user_uni], role: "TA"}).pluck(:courseName)
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
            courseName: @calendar.courseName,
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

  def edit_office_hour
    @courseNames = current_user.calendars.uniq(&:courseName).map(&:courseName).to_set
  
    if params[:courseName].present?
      @filtered_calendars = current_user.calendars.select { |calendar| calendar.courseName == params[:courseName] }
    else
      @filtered_calendars = current_user.calendars
    end
    logger.debug @courseNames
  end

  def update
    @calendar = Calendar.find(params[:id])
  
    if @calendar.update(calendar_params)
      redirect_to edit_office_hour_teaching_assistants_path, notice: 'Office hour was successfully updated.'
    else
      render :edit_office_hour
    end
  end
  
  private

  def calendar_params
    params.require(:calendar).permit(:courseName, :start_time, :end_time, :recurrence)
  end
end
