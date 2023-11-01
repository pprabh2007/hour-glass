class EntitlementsController < ApplicationController

    def create
        course_name = entitlement_params[:courseName]
        input_course = Course.find_by(courseName: course_name)
        if input_course.nil?
            flash[:warning] = "No such class exists. Please input a valid class."
        else
            if Entitlement.equivalent_perm_exists?(current_user.uni, input_course.id, entitlement_params[:role])
                flash[:warning] = "You already have access to the inputted class."
            else
                new_entitlement = Entitlement.create(uni: current_user.uni, courseId: input_course.courseName, role: entitlement_params[:role])
                flash[:notice] = "Added new class '#{course_name}' to schedule";
            end
        end
        redirect_to user_profile_path
    end
  
    private
    def entitlement_params
        params.require(:entitlement).permit(:courseName, :role)
    end
end
  
