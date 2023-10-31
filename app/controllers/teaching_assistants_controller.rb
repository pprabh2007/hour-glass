class TeachingAssistantsController < ApplicationController
    before_action :set_teaching_assistant, only: [:show, :edit, :update, :destroy]
    skip_before_action :authenticate_user, only: [:new_office_hour, :create_office_hour] # Skip authentication for specific actions
  
    def index
      @teaching_assistants = TeachingAssistant.all
    end
  
    def show
      if params[:id] != 'new_office_hour' # Check if ID is not 'new_office_hour'
        @teaching_assistant = TeachingAssistant.find(params[:id])
      else
        redirect_to teaching_assistants_path, alert: "Teaching Assistant not found"
      end
    end
  
    def new
      @teaching_assistant = TeachingAssistant.new
    end
  
    def create
      @teaching_assistant = TeachingAssistant.new(teaching_assistant_params)
  
      if @teaching_assistant.save
        redirect_to @teaching_assistant, notice: 'Teaching Assistant was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      # Add any necessary code for editing the TA's details
    end
  
    def update
      if @teaching_assistant.update(teaching_assistant_params)
        redirect_to @teaching_assistant, notice: 'Teaching Assistant was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @teaching_assistant.destroy
      redirect_to teaching_assistants_url, notice: 'Teaching Assistant was successfully destroyed.'
    end
  
    def new_office_hour
      if params[:id] && params[:id] != 'new_office_hour'
        @teaching_assistant = TeachingAssistant.find_by(id: params[:id])
      else
        @teaching_assistant = TeachingAssistant.new
      end
      @calendar = @teaching_assistant.calendars.build if @teaching_assistant
    end
  
    def create_office_hour
      @teaching_assistant = TeachingAssistant.find_by(id: params[:teaching_assistant_id])
      if @teaching_assistant
        if @teaching_assistant.calendars.exists?(teaching_assistant_id: nil) # Check if the teaching_assistant_id is nil
          redirect_to new_office_hour_path, alert: "Teaching Assistant ID is missing in the calendar."
        else
          @calendar = @teaching_assistant.calendars.build(calendar_params)
          if @calendar.save
            redirect_to calendar_path(@calendar), notice: 'Office hours were successfully added.'
          else
            render :new_office_hour
          end
        end
      else
        redirect_to teaching_assistants_path, alert: "Teaching Assistant not found"
      end
    end
    
  
    private
  
    def set_teaching_assistant
      if params[:id].present? && params[:id] != 'new_office_hour' # Check if ID is not 'new_office_hour'
        @teaching_assistant = TeachingAssistant.find_by(id: params[:id])
      end
    end
  
    def teaching_assistant_params
      params.require(:teaching_assistant).permit(:name, :uni, :class_id) # Adjust the permitted parameters as needed
    end
  
    private
  
    def calendar_params
      params.require(:calendar).permit(:class_id, :start_time, :end_time, :teaching_assistant_id)
    end
  end
  