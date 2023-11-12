class EntitlementsController < ApplicationController

    def create
        course_name = entitlement_params[:courseName]
        input_course = Course.find_by(courseName: course_name)
        if Entitlement.equivalent_perm_exists?(current_user.uni, course_name, entitlement_params[:role])
            flash[:warning] = "You already have access to the inputted class."
        else
            new_entitlement = Entitlement.create(uni: current_user.uni, courseId: course_name, role: entitlement_params[:role])
            flash[:notice] = "Added new class '#{course_name}' to schedule";
        end
        redirect_to user_profile_path
    end
  
    private
    def entitlement_params
        params.require(:entitlement).permit(:courseName, :role)
    end
end
  
