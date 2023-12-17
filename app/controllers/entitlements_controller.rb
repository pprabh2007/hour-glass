class EntitlementsController < ApplicationController

    def create
        course_name = entitlement_params[:courseName]
        if course_name.empty?
            flash[:warning] = "Please choose a valid class to start viewing."
        else
            if Entitlement.equivalent_perm_exists?(current_user.uni, course_name, entitlement_params[:role])
                flash[:warning] = "You already have access to the inputted class."
            else
                new_entitlement = Entitlement.create(uni: current_user.uni, courseName: course_name, role: entitlement_params[:role])
                flash[:notice] = "Added new class '#{course_name}' to schedule";
            end
        end
        redirect_to user_profile_path
    end

    def delete_viewer
        course_name = delete_params[:courseName]
        is_ta_or_higher = Entitlement.equivalent_perm_exists?(current_user.uni, course_name, "TA")
        can_view_course = Entitlement.equivalent_perm_exists?(current_user.uni, course_name, "Viewer")
        if is_ta_or_higher
            flash[:warning] = "Cannot remove the class as you are an administrator for the class";
        elsif can_view_course
            Entitlement.find_by(uni: current_user.uni, courseName: course_name).destroy
            flash[:notice] = "Removed the class '#{course_name}' from your schedule";
        else
            flash[:warning] = "Could not find entitlements for '#{course_name}' in your schedule";
        end
        redirect_to user_profile_path
    end
  
    private
    def entitlement_params
        params.require(:entitlement).permit(:courseName, :role)
    end

    private
    def delete_params
        params.require(:entitlement).permit(:courseName)
    end
end
  
