# spec/controllers/professors_controller_spec.rb
require 'rails_helper'

RSpec.describe ProfessorsController, type: :controller do
  let(:user) { User.create(name: "testProfessor", uni: "testProfessor", password: "testPassword", is_professor: true) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'before_action :require_professor_entitlement' do
    context 'when user is not a professor' do
      it 'redirects to user profile with a warning flash' do
        session[:user_name] = user.name
        session[:user_uni] = user.uni
        session[:user_password] = user.password
        allow(controller).to receive(:current_user).and_return(User.create(name: "testStudent", uni: "testStudent", password: "testPassword"))

        get :index

        expect(response).to redirect_to(user_profile_path)
        expect(flash[:warning]).to eq("You do not have permission to add new courses")
      end
    end

    context 'when user is a professor' do
      it 'allows access to the action' do
        session[:user_name] = user.name
        session[:user_uni] = user.uni
        session[:user_password] = user.password
        get :index

        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #index' do
    it 'assigns viewable courses and renders the index template' do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      entitlement = Entitlement.create(uni: user.uni, courseName: "COMS 4152", role: "Prof")
      course = Course.create(courseName: "COMS 4152", courseDescription: "Engineering Software-as-a-Service")

      get :index

      expect(assigns(:viewable_courses)).to contain_exactly(course)
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new course and entitlements' do
        session[:user_name] = user.name
        session[:user_uni] = user.uni
        session[:user_password] = user.password
        post :create, {
          :professor => {
            "courseName" => 'COMS 4152',
            "courseDescription" => 'Engineering Software-as-a-Service',
            "unis" => 'TA1, TA2'
          }
        }

        expect(response).to redirect_to(user_profile_path)
        expect(flash[:notice]).to eq("Successfully created new course 'COMS 4152:Engineering Software-as-a-Service'.")
        expect(Course.find_by(courseName: 'COMS 4152')).to be_present
        expect(Entitlement.where(courseName: 'COMS 4152')).to_not be_empty
      end
    end

    context 'with existing course name' do
      it 'sets a warning flash and redirects to user profile' do
        session[:user_name] = user.name
        session[:user_uni] = user.uni
        session[:user_password] = user.password
        Course.create(courseName: 'COMS 4152', courseDescription: 'Engineering Software-as-a-Service')

        post :create, {
          :professor => {
            "courseName" => 'COMS 4152',
            "courseDescription" => 'Data Structures',
            "unis" => 'TA1, TA2'
          }
        }

        expect(response).to redirect_to(professors_path)
        expect(flash[:warning]).to eq("Error: Course 'COMS 4152' already exists.")
      end
    end
  end
end
