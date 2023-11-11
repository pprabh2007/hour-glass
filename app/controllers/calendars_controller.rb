class CalendarsController < ApplicationController

    def index
      user_id = session[:user_id]
      user = User.find_by(id: user_id)

      uni = user.uni
      
      classes = Entitlement.where(uni: uni).pluck(:courseId)
      @calendars = Calendar.where(class_id: classes)
    end

    def destroy
      @calendar = Calendar.find(params[:id])
      @calendar.destroy
      redirect_to edit_office_hour_teaching_assistants_path, notice: 'Office hour was successfully deleted.'
    end

end
