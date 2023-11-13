class EntitlementsController < ApplicationController

    def create
        course_name = entitlement_params[:courseName]
        if course_name.empty?
            flash[:warning] = "Please choose a valid class to start viewing."
        else
            input_course = Course.find_by(courseName: course_name)
            if Entitlement.equivalent_perm_exists?(current_user.uni, course_name, entitlement_params[:role])
                flash[:warning] = "You already have access to the inputted class."
            else
                new_entitlement = Entitlement.create(uni: current_user.uni, courseName: course_name, role: entitlement_params[:role])
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
  
