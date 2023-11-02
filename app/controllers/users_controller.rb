require 'set'

class UsersController < ApplicationController

    skip_before_action :require_login, only: [:create]

    def profile

        @viewable_courses = Set.new
        @calendars = Set.new(current_user.calendars)
        @entitlements = Entitlement.where(uni: current_user.uni)
        @entitlements.each do |entitlement|
            if not Course.find_by(id: entitlement.courseId).nil?
                @viewable_courses << Course.find_by(id: entitlement.courseId)
            end
        end
    end

    def create
        existing_user = User.find_by(uni: user_params[:uni])
        if existing_user
            flash[:warning] = "Inputted UNI already has an account. Please log in instead."
            redirect_to new_session_path
        else
            new_user = User.create(user_params)
            session[:user_id] = new_user.id
            redirect_to user_profile_path
        end
    end
  
    private 
    def user_params
      params.require(:user).permit(:uni, :name, :password)
    end
  end
