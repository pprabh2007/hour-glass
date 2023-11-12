require 'date'

class CalendarsController < ApplicationController

    def index
      
      if not params.key?(:year)
        current_sunday = get_last_sunday_date(Date.today)
      else
        current_sunday = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      end
      user_id = session[:user_id]
      user = User.find_by(id: user_id)
      uni = user.uni

      @year = current_sunday.year
      @month = current_sunday.month
      @day = current_sunday.day 
      @all_days = []
      for i in 0..6
        @all_days.append(days_map[i])
      end
      dtstart = DateTime.new(@year, @month, @day)
      dtend = dtstart + 7

      classes = Entitlement.where(uni: uni).pluck(:courseName)
      @calendars = Calendar.where(courseName: classes).where('start_time >= ? AND end_time < ?', dtstart, dtend).order(:start_time)
      @calendars = @calendars.map do |calendar|
        new_calendar = OpenStruct.new(calendar.attributes)
        new_calendar.wday = idx_to_day(calendar.start_time.wday)
        new_calendar
      end
    end

    def destroy
      @calendar = Calendar.find(params[:id])
      @calendar.destroy
      redirect_to edit_office_hour_teaching_assistants_path, notice: 'Office hour was successfully deleted.'
    end

    def edit
      @calendar = Calendar.find(params[:id])
    end
    
    def update
      if @calendar.update(calendar_params)
        redirect_to edit_office_hour_teaching_assistants_path, notice: 'Office hour was successfully updated.'
      else
        render :edit
      end
    end

    def next_week
        year = params[:year].to_i
        month = params[:month].to_i
        day = params[:day].to_i

        next_date = Date.new(year, month, day) + 7
        redirect_to calendars_path({year: next_date.year, month: next_date.month, day: next_date.day})
    end

    def prev_week
        year = params[:year].to_i
        month = params[:month].to_i
        day = params[:day].to_i
        
        prev_date = Date.new(year, month, day) - 7
        redirect_to calendars_path({year: prev_date.year, month: prev_date.month, day: prev_date.day})
    end

    def get_last_sunday_date(date)
        date - date.wday
    end

    def idx_to_day(idx)
        days_map[idx]
    end
    def days_map
        {0 => "Sunday", 
        1 => "Monday", 
        2 => "Tuesday",
        3 => "Wednesday",
        4 => "Thursday",
        5 => "Friday",
        6 => "Saturday"}
    end
end

