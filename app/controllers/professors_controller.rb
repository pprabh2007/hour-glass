class ProfessorsController < ApplicationController

    def index
      @viewable_courses = Set.new
        @entitlements = Entitlement.where(uni: current_user.uni)
        @entitlements.each do |entitlement|
            if not Course.find_by(id: entitlement.courseId).nil?
              @viewable_courses << Course.find_by(id: entitlement.courseId)
            end
      end
    end
  
    def create
      name = professors_params[:courseName]
      description = professors_params[:courseDescription]
      unis =professors_params[:unis]

      if Course.find_by(courseName: name).nil?
        course = Course.create!({:courseName => name, :courseDescription => description})
        Entitlement.create!({:uni => current_user.uni, :courseId => course.id, :role => "Prof"})
        unis.split( /, */ ).each { |uni| Entitlement.create!({:uni => uni, :courseId => course.id, :role => "TA"})}
        TeachingAssistant.new(teaching_assistant_params)
        flash[:notice] = "Successfully created new course \'#{name}:#{description}\'."
      else
        flash[:warning] = "Error: Course \'#{name}\' already exists."
      end
      redirect_to professors_path
    end

    private
    def professors_params
        params.require(:professor).permit(:courseName, :courseDescription, :unis, :role)
    end

end