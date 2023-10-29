class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
    session[:user_id] = nil
  end

  def create
    @user = User.find_by(uni: login_params[:uni])
    if @user && @user.authenticate(login_params[:password])
      session[:user_id] = @user.id
      redirect_to user_profile_path
    else 
      flash[:warning] = "Invalid login. Please try again."
      redirect_to new_session_path
    end
  end

  def clear
    flash[:notice] = "You have successfully logged out."
    redirect_to new_session_path
  end

  private 
  def login_params
    params.require(:login).permit(:uni, :name, :password)
  end
end
