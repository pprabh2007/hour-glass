require 'rails_helper'
require 'set'

RSpec.describe EntitlementsController, type: :controller do
    let(:existingUser) { User.create(name: "testStudent", uni: "testStudentUni", password: "testPassword") }
    let(:existingViewerEntitlement) { Entitlement.create(uni: "testStudentUni",  courseName: "COMS 4152", role: "Viewer" ) }
    let(:firstCourse) { Course.create( courseName: "COMS 4152", courseDescription: "Engineering Software-as-a-Service", created_at: DateTime.new(2023, 1, 1), updated_at: DateTime.new(2023, 1, 1)) } 
    let(:secondCourse) { Course.create( courseName: "CSOR 4231", courseDescription: "Algos", created_at: DateTime.new(2023, 1, 1), updated_at: DateTime.new(2023, 1, 1)) } 

    before do
        allow(controller).to receive(:current_user).and_return(existingUser)
    end

    describe "POST #create" do
        context "with a valid courseName" do
            it "does not create a new entitlement if a stronger one already exists and redirects to profile page" do
                session[:user_uni] = existingUser.uni
                post :create, entitlement: {courseName: existingViewerEntitlement.courseName, role: existingViewerEntitlement.role}  # Current user has viewer entitlement already
                expect(flash[:warning]).to eq("You already have access to the inputted class.")
                expect(response).to have_http_status(:redirect)
                expect(response).to redirect_to(user_profile_path) # To new user profile page
            end

            it "creates a new entitlement if a stronger one does not yet exist and redirects to profile page" do
                session[:user_uni] = existingUser.uni
                post :create, entitlement: {courseName: secondCourse.courseName, role: 'Viewer'} # Current user does not have perms for this class
                expect(flash[:notice]).to eq("Added new class '" + secondCourse.courseName + "' to schedule")
                expect(response).to have_http_status(:redirect)
                expect(response).to redirect_to(user_profile_path) # To new user profile page
            end
        end

        context "with an empty course name" do
            it "it gives a warning" do
                session[:user_uni] = existingUser.uni
                post :create, entitlement: {courseName: '', role: existingViewerEntitlement.role}
                expect(flash[:warning]).to eq("Please choose a valid class to start viewing.")
                expect(response).to have_http_status(:redirect)
                expect(response).to redirect_to(user_profile_path) # To new user profile page
            end
        end
    end

    describe "private #entitlement_params" do
        it "permits the correct parameters" do
            params = ActionController::Parameters.new(entitlement: { "courseName" => "testCourse", "role" => "Viewer"})
            permitted_params = params.require(:entitlement).permit(:courseName, :role)
            expect(permitted_params).to eq({ "courseName" => "testCourse", "role" => "Viewer"})
        end
    end
end