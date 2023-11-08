class TeachingAssistantsController < ApplicationController
    before_action :set_teaching_assistant, only: [:show, :edit, :update, :destroy]
    skip_before_action :authenticate_user, only: [:new_office_hour, :create_office_hour]
  
    def new_office_hour
        # @teaching_assistant = TeachingAssistant.find_by(id: params[:id]) if params[:id] && params[:id] != 'new_office_hour'
        # @teaching_assistant ||= TeachingAssistant.new
        @calendar = Calendar.new
      end       
      
      def create_office_hour
        @calendar = current_user.calendars.build(calendar_params)
      
        if @calendar.save
          redirect_to user_profile_path, notice: 'Office hours were successfully added.'
        else
          render :new_office_hour
        end
      end
  
    private
    def calendar_params
      params.require(:calendar).permit(:class_id, :start_time, :end_time, :teaching_assistant_id)
    end
  end
  