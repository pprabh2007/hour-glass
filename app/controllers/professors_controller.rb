class ProfessorsController < ApplicationController

    before_action :require_professor_entitlement

    def require_professor_entitlement
      if current_user.is_professor != true
        flash[:warning] = "You do not have permission to add new courses"
        redirect_to user_profile_path
      end
    end

    def index
      @viewable_courses = Hash.new
        @entitlements = Entitlement.where(uni: current_user.uni, role: "Prof")
        @entitlements.each do |entitlement|
          potential_course = Course.find_by(courseName: entitlement.courseName)
            if not potential_course.nil?
              @tas = Entitlement.where(courseName: potential_course.courseName, role: "TA")
              @talist = Set.new
              @tas.each do |ta|
                @talist << ta.uni
              end
              @viewable_courses[potential_course] = @talist
            end
      end
    end
  
    def create
      name = professors_params[:courseName]
      description = professors_params[:courseDescription]
      unis =professors_params[:unis]

      if Course.find_by(courseName: name).nil?
        course = Course.create!({:courseName => name, :courseDescription => description})
        Entitlement.create!({:uni => current_user.uni, :courseName => course.courseName, :role => "Prof"})
        unis.split( /, */ ).each { |uni| Entitlement.create!({:uni => uni, :courseName => course.courseName, :role => "TA"})}
        flash[:notice] = "Successfully created new course \'#{name}:#{description}\'."
        redirect_to professors_path
      else
        flash[:warning] = "Error: Course \'#{name}\' already exists."
        redirect_to professors_path
      end
    end

    private
    def professors_params
        params.require(:professor).permit(:courseName, :courseDescription, :unis, :role)
    end

end