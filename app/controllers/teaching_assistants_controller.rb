class TeachingAssistantsController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user, only: [:new_office_hour, :create_office_hour]

  def new_office_hour
    @your_classes = Entitlement.where({uni: current_user.uni, role: ["TA", "Prof"]}).pluck(:courseName)
    @calendar = Calendar.new
  end

  def create_office_hour
    @calendar = current_user.calendars.build(calendar_params)
    if @calendar.save
      if @calendar.repeated_weeks.positive?
        start_time = @calendar.start_time.advance(weeks: 1)
        end_time = @calendar.end_time.advance(weeks: 1)
        repeated_weeks = @calendar.repeated_weeks
  
        while start_time <= repeated_weeks.weeks.from_now(@calendar.start_time)
          new_calendar = current_user.calendars.build(
            courseName: @calendar.courseName,
            start_time: start_time,
            end_time: end_time,
            repeated_weeks: @calendar.repeated_weeks
          )
          new_calendar.save
          start_time = start_time.advance(weeks: 1)
          end_time = end_time.advance(weeks: 1)
        end
        redirect_to user_profile_path, notice: 'Office hours were successfully added.'
      else
        redirect_to user_profile_path, notice: 'Office hour was successfully added.'
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
    params.require(:calendar).permit(:courseName, :start_time, :end_time, :repeated_weeks)
  end
end
