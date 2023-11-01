class SchedulesController < ApplicationController

    def index
      user_id = session[:user_id]
      user = User.find_by(id: user_id)

      uni = user.uni
      
      classes = Entitlement.where(uni: uni).pluck(:courseId)
      @sched = Schedule.where(courseId: classes)
    end

end
