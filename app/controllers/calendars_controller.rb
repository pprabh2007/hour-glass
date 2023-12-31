require 'date'
require 'active_support/time'

class CalendarsController < ApplicationController

    def index
      if not params.key?(:year)
        current_sunday = get_last_sunday_date(Date.today)
      else
        current_sunday = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      end

      @year = current_sunday.year
      @month = current_sunday.month
      @day = current_sunday.day 
      
      dtstart = DateTime.new(@year, @month, @day)
      dtend = dtstart + 7
      
      @all_days = []
      for i in 0..6
        @all_days.append({wday: days_map[i], date: (dtstart + i).strftime('%m/%d/%Y')})
      end

      # The pluck method works for application usage here, but runs into issues with Rspec testing due to our old Ruby version. 
      # Simiplified to a for loop for now
      my_entitlements = Entitlement.where(uni: current_user.uni)
      classes = []
      my_entitlements.each do |entitlement|
        if not entitlement.courseName.nil?
          classes << entitlement.courseName
        end
      end

      @calendars = Calendar.where(courseName: classes).where('start_time >= ? AND end_time < ?', dtstart, dtend).order(:start_time)
      @calendars = @calendars.map do |calendar|
        new_calendar = OpenStruct.new(calendar.attributes)
        new_calendar.wday = idx_to_day(calendar.start_time.wday)
        new_calendar
      end

      @calendar_edits = CalendarEdit.where(courseName: classes)
                        .where('start_time >= ? AND end_time < ?', dtstart, dtend)
                        .order(:update_time).group_by(&:courseName)
      @edit_description = method(:edit_description)
    end

    def destroy
      @calendar = Calendar.find(params[:id])
      create_calendar_deletion(@calendar)
      @calendar.destroy
      redirect_to edit_office_hour_teaching_assistants_path, notice: 'Office hour was successfully deleted.'
    end

    def create_calendar_deletion(calendar)
        CalendarEdit.create(
          courseName: calendar.courseName,
          start_time: calendar.start_time,
          end_time: calendar.end_time,
          location: calendar.location,
          user_id: calendar.user_id,
          edit_type: CalendarEdit.edit_types[:deletion], # Assuming you have an enum in CalendarEdit for edit_type
          update_time: DateTime.now.in_time_zone("EST")
        )
    end

    def edit_description(edit)
      user = User.find(edit.user_id).uni
      
      u_time = tFmt(edit.update_time.in_time_zone('EST'), 'DT')
      s_day = tFmt(edit.start_time, 'D')
      s_time = tFmt(edit.start_time, 'T')
      e_time = tFmt(edit.end_time, 'T')
      case edit.edit_type
      when 'update_deletion'
        "[#{u_time}] #{user}: Not holding OH originally scheduled on #{s_day} from #{s_time} to #{e_time} at #{edit.location}."
      when 'update_addition'
        "[#{u_time}] #{user}: Conducting replacement OH on #{s_day} from #{s_time} to #{e_time} at #{edit.location}"
      when 'deletion'
        "[#{u_time}] #{user}: Cancelling OH on #{s_day} from #{s_time} to #{e_time} at #{edit.location}"
      end
    end

    def tFmt(t, mode)
      case mode
      when 'DT'
        t.strftime('%m/%d/%Y %H:%M')
      when 'D'
        t.strftime('%b %d (%A)')
      when 'T'
        t.strftime('%H:%M')
      end
    end

    def edit
      @calendar = Calendar.find(params[:id])
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

