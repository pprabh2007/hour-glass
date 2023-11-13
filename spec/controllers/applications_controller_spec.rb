require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: "Hello, World!"
    end
  end

  describe "require_login" do
    let(:user) { User.create(name: "Test User", uni: "testuni", password: "password") }

    it "redirects to new_session_path if no user is logged in" do
      get :index
      expect(response).to redirect_to(new_session_path)
    end

    it "redirects to new_session_path if unknown user is logged in" do
      session[:user_uni] = 'unknownUni'
      get :index
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "current_user" do
    let(:user) { User.create(name: "Test User", uni: "testuni", password: "password") }

    it "returns current user if session user_uni is present" do
      session[:user_uni] = user.uni
      expect(controller.current_user).to eq(user)
    end

    it "returns nil if session user_uni is not present" do
      session[:user_uni] = nil
      expect(controller.current_user).to be_nil
    end
  end
end
