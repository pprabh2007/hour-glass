class ProfessorsController < ApplicationController

    def index
      puts "hi"
    end
  
    def create
      code = professors_params[:courseCode]
      name = professors_params[:courseName]
      unis =professors_params[:unis]
      value = Course.find_by(id: id)
      puts value.courseName
      if Course.find_by(courseCode: code).nil?
        Course.create!({:courseCode => code, :courseName => name})
        puts "In here"
        flash[:warning] = "Successfully Created New Course."
      else
        flash[:warning] = "Error: A Course With This CourseId Already Exists."
      end
      redirect_to professors_path
    end

    private
    def professors_params
        params.require(:professor).permit(:courseCode, :courseName, :unis, :role)
    end

end