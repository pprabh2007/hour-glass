require 'rails_helper'
require 'set'

RSpec.describe SessionsController, type: :controller do
  let(:existingUser) { User.create(name: "testStudent", uni: "testStudentUni", password: "testPassword") }

  describe "POST #create" do
    context "with existing user login attributes" do
      it "creates a new session and redirects to profile page" do
        post :create, login: { uni: existingUser.uni, name: existingUser.name, password: existingUser.password }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(user_profile_path) # To new user profile page
      end
    end

    context "with wrong password" do
        it "it redirects back to the login page" do
          post :create, login: { uni: existingUser.uni, name: existingUser.name, password: "badPassword" } 
          expect(response).to have_http_status(:redirect)
          expect(response).to redirect_to(new_session_path) # Back to log in page
        end
    end

    context "with non-existing user attributes" do
      it "it redirects back to the login page" do
        post :create, login: { uni: "testNewUni", name: "testNewName", password: "testPassword" } 
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_session_path) # Back to log in page
      end
    end
  end

  describe "private #login_params" do
    it "permits the correct parameters" do
      params = ActionController::Parameters.new(login: { "uni" => "testUni", "name" => "testName", "password" => "testPassword"})
      permitted_params = params.require(:login).permit(:uni, :name, :password)
      expect(permitted_params).to eq({"uni" => "testUni", "name" => "testName", "password" => "testPassword"})
    end
  end

  describe "GET #new" do
    it "deletes existing session uni and render login template" do
      session[:user_uni] = existingUser.uni
      get :new
      expect(session[:user_uni].nil?).to eq(true)
      expect(response).to render_template(:new) # renders log in template
    end
  end

  describe "GET #clear" do
    it "leave a logout message and redirect to new session path" do
      session[:user_uni] = existingUser.uni
      get :clear
      expect(flash[:notice]).to eq("You have successfully logged out.")
      expect(response).to redirect_to(new_session_path) # deletes existing session uni and renders log in template
    end
  end
end