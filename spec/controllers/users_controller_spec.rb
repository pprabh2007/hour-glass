require 'rails_helper'
require 'set'

RSpec.describe UsersController, type: :controller do
  let(:studentUser) { User.create(name: "testStudent", uni: "testStudentUni", password: "testPassword") }
  let(:studentEntitlements) { Entitlement.create({ uni: "testStudentUni", courseName: "COMS 4152", role: "Viewer",
  created_at: DateTime.new(2023, 1, 1), updated_at: DateTime.new(2023, 1, 1) }) }
  let(:firstCourse) { Course.create( courseName: "COMS 4152", courseDescription: "Engineering Software-as-a-Service", created_at: DateTime.new(2023, 1, 1), updated_at: DateTime.new(2023, 1, 1)) } 
  let(:secondCourse) { Course.create( courseName: "CSOR 4231", courseDescription: "Algos", created_at: DateTime.new(2023, 1, 1), updated_at: DateTime.new(2023, 1, 1)) } 

  before do
    allow(controller).to receive(:current_user).and_return(studentUser)
    allow(Entitlement).to receive(:where).with(uni: studentUser.uni).and_return([studentEntitlements])
    allow(Course).to receive(:find_by).with(courseName: firstCourse.courseName).and_return(firstCourse)
    allow(Course).to receive(:find_by).with(courseName: secondCourse.courseName).and_return(secondCourse)
  end

  describe "GET #profile" do
    it "renders user profile page and returns appropriate viewable courses" do
        session[:user_uni] = studentUser.uni
        get :profile
        expect(response).to render_template(:profile)
        expect(assigns(:entitlements)).to eq([studentEntitlements])

        # Should include first course as student has viewer entitlement for it, 
        # but not the second course
        expect(assigns(:viewable_courses).length).to eq(1)
        expect(assigns(:viewable_courses)).to include(firstCourse)
        expect(assigns(:viewable_courses)).not_to include(secondCourse)
    end
  end

  describe "POST #create" do
    context "with valid user attributes" do
      it "creates a new User and redirects to profile page" do
        post :create, user: { uni: "testNewUni", name: "testNewName", password: "testPassword", is_professor: false }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(user_profile_path) # To new user profile page
      end
    end

    context "with an already existing user's uni" do
      it "it redirects back to the login page without creating a user" do
        post :create, user: { uni: "testStudentUni", name: "testStudentName", password: "testPassword", is_professor: false } 
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_session_path) # Back to log in page
      end
    end
  end

  describe "private #user_params" do
    it "permits the correct parameters" do
      params = ActionController::Parameters.new(user: { "uni" => "testUni", "name" => "testName", "password" => "testPassword", "is_professor" => false })
      permitted_params = params.require(:user).permit(:uni, :name, :password, :is_professor)
      expect(permitted_params).to eq({ "uni" => "testUni", "name" => "testName", "password" => "testPassword", "is_professor" => false })
    end
  end
end