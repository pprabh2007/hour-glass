class TeachingAssistantsController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user, only: [:new_office_hour, :create_office_hour]

  def new_office_hour
    @your_classes = Entitlement.where({uni: current_user.uni, role: ["TA", "Prof"]}).map(&:courseName)
    @calendar = Calendar.new

    @entitlements = Entitlement.where(uni: current_user.uni, role: ["TA", "Prof"])
  end

  def create_office_hour
    if not valid_calendar
      flash[:warning] = 'All calendar events must end on the same day and strictly after the start time'
      redirect_to new_office_hour_teaching_assistants_path
    elsif
      @calendar = current_user.calendars.build(calendar_params)
      @entitlements = Entitlement.where(uni: current_user.uni, role: ["TA", "Prof"])
      if @calendar.save
        if @calendar.repeated_weeks.positive?
          start_time = @calendar.start_time.advance(weeks: 1)
          end_time = @calendar.end_time.advance(weeks: 1)
          repeated_weeks = @calendar.repeated_weeks
          location = @calendar.location
    
          while start_time <= repeated_weeks.weeks.from_now(@calendar.start_time)
            new_calendar = current_user.calendars.build(
              courseName: @calendar.courseName,
              start_time: start_time,
              end_time: end_time,
              repeated_weeks: @calendar.repeated_weeks,
              location: @calendar.location
            )
            new_calendar.save
            start_time = start_time.advance(weeks: 1)
            end_time = end_time.advance(weeks: 1)
          end
          redirect_to user_profile_path, notice: 'Office hours were successfully added.'
        else
          redirect_to user_profile_path, notice: 'Office hour was successfully added.'
        end
      end
    end
  end

  def edit_office_hour
    @courseNames = current_user.calendars.uniq(&:courseName).map(&:courseName).to_set
    if params[:courseName].present?
      @filtered_calendars = current_user.calendars.select { |calendar| calendar.courseName == params[:courseName] }
    else
      @filtered_calendars = current_user.calendars
    end
    @entitlements = Entitlement.where(uni: current_user.uni, role: ["TA", "Prof"])
  end

  def update
    @calendar = Calendar.find(params[:id])

    time = DateTime.now
    calendar_update_del = get_calendar_update(@calendar, time, :update_deletion) 
    if not valid_calendar
      flash[:warning] = 'All calendar events must end on the same day and strictly after the start time'
      redirect_to edit_calendar_path(@calendar)
    elsif @calendar.update(calendar_params)  
      calendar_update_add = get_calendar_update(@calendar, time, :update_addition)
      calendar_update_del.save
      calendar_update_add.save 
      redirect_to edit_office_hour_teaching_assistants_path, notice: 'Office hour was successfully updated.'
    end
  end
  
  def get_calendar_update(calendar, time, op)
    CalendarEdit.new(
      courseName: calendar.courseName,
      start_time: calendar.start_time,
      end_time: calendar.end_time,
      location: calendar.location,
      user_id: calendar.user_id,
      edit_type: CalendarEdit.edit_types[op], # Assuming you have an enum in CalendarEdit for edit_type
      update_time: time
    )
  end

  private
  def calendar_params
    params.require(:calendar).permit(:courseName, :start_time, :end_time, :repeated_weeks, :location)
  end

  private
  def valid_calendar
    params = calendar_params
    any_field_missing = params["start_time(1i)"].nil? or params["start_time(2i)"].nil? or params["start_time(3i)"].nil? or params["start_time(4i)"].nil? or params["start_time(5i)"].nil? or params["end_time(1i)"].nil? or params["end_time(2i)"].nil? or params["end_time(3i)"].nil? or params["end_time(4i)"].nil? or params["end_time(5i)"].nil?
    if any_field_missing
      return false
    end
    start_year = params["start_time(1i)"].to_i
    start_month = params["start_time(2i)"].to_i
    start_day = params["start_time(3i)"].to_i
    start_hour = params["start_time(4i)"].to_i
    start_minute = params["start_time(5i)"].to_i
    end_year = params["end_time(1i)"].to_i
    end_month = params["end_time(2i)"].to_i
    end_day = params["end_time(3i)"].to_i
    end_hour = params["end_time(4i)"].to_i
    end_minute = params["end_time(5i)"].to_i
    Date.new(start_year, start_month, start_day) === Date.new(end_year, end_month, end_day) and DateTime.new(start_year, start_month, start_day, start_hour, start_minute) < DateTime.new(end_year, end_month, end_day, end_hour, end_minute)
  end
end
