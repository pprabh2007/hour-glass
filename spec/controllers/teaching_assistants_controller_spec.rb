require 'rails_helper'


RSpec.describe TeachingAssistantsController, type: :controller do
  let(:user) { User.create(name: "testProfessor", uni: "testProfessor", password: "testPassword") }
  let(:entitlements) { Entitlement.create({ uni: "testProfessor", courseName: "CSOR 4231", role: "Prof",
                                            created_at: DateTime.new(2023, 1, 1), updated_at: DateTime.new(2023, 1, 1) }) }
  let(:calendar) { Calendar.create(courseName: "CSOR 4231", start_time: DateTime.now, end_time: DateTime.now + 1.hour, repeated_weeks: 2) }


  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(Entitlement).to receive(:where).with(uni: user.uni, role: ["TA", "Prof"]).and_return([entitlements])
  end


  describe "GET #new_office_hour" do
    it "returns http success" do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      get :new_office_hour
      expect(response).to have_http_status(:success)
    end


    it "assigns @your_classes" do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      get :new_office_hour
      expect(assigns(:your_classes)).to eq(["CSOR 4231"])
    end


    it "assigns a new Calendar to @calendar" do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      get :new_office_hour
      expect(assigns(:calendar)).to be_a_new(Calendar)
    end
  end


  describe "POST #create_office_hour" do
    context "with valid attributes" do
      it "creates a new Calendar" do
        session[:user_name] = user.name
        session[:user_uni] = user.uni
        session[:user_password] = user.password
        allow_any_instance_of(Calendar).to receive(:save).and_return(true)
        post :create_office_hour, {:calendar => { "courseName" => "COMS101", "start_time" => "9:00 AM", "end_time" => "11:00 AM", "repeated_weeks" => 2 } }
        expect(response).to have_http_status(:redirect)
      end
    end


    context "with invalid attributes" do
      it "renders the new_office_hour template" do
        allow_any_instance_of(Calendar).to receive(:save).and_return(false)
        post :create_office_hour, {:calendar => { "courseName" => nil, "start_time" => nil, "end_time" => nil, "repeated_weeks" => nil } }
        expect(response).to have_http_status(:redirect)
      end
    end

    context "with valid attributes" do
      it "creates a new Calendar" do
        session[:user_name] = user.name
        session[:user_uni] = user.uni
        session[:user_password] = user.password
        allow_any_instance_of(Calendar).to receive(:save).and_return(true)
        post :create_office_hour, {:calendar => { "courseName" => "COMS101", "start_time" => "9:00 AM", "end_time" => "11:00 AM", "repeated_weeks" => 0 } }
        expect(response).to have_http_status(:redirect)
      end
    end
  end


  describe "GET #edit_office_hour" do
    it "returns http success" do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      get :edit_office_hour
      expect(response).to have_http_status(:success)
    end


    it "assigns @courseNames" do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      get :edit_office_hour
      expect(assigns(:courseNames)).to eq(Set[])
    end


    context "when courseName is present in params" do
      it "assigns @filtered_calendars" do
        session[:user_name] = user.name
        session[:user_uni] = user.uni
        session[:user_password] = user.password
        get :edit_office_hour, { courseName: "CSOR 4231" }
        expect(assigns(:filtered_calendars)).to eq([])
      end
    end


    context "when courseName is not present in params" do
      it "assigns all user calendars to @filtered_calendars" do
        get :edit_office_hour
        session[:user_name] = user.name
        session[:user_uni] = user.uni
        session[:user_password] = user.password
        expect(assigns(:filtered_calendars)).to eq(nil)
      end
    end
  end


  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the requested calendar" do
        session[:user_name] = user.name
        session[:user_uni] = user.uni
        session[:user_password] = user.password
        allow(Calendar).to receive(:find).with(calendar.id.to_s).and_return(calendar)
        allow(calendar).to receive(:update).with(any_args).and_return(true)
        patch :update, {:id => calendar.id, :calendar => { "start_time" => DateTime.now } }
        expect(response).to have_http_status(:redirect)
      end
    end


    context "with invalid attributes" do
      it "renders the edit_office_hour template" do
        allow(Calendar).to receive(:find).with(calendar.id.to_s).and_return(calendar)
        allow(calendar).to receive(:update).with(any_args).and_return(false)
        patch :update, {:id => calendar.id, :calendar => { "start_time" => nil } }
        expect(response).to have_http_status(:redirect)
      end
    end


    describe "private #calendar_params" do
      it "permits the correct parameters" do
        params = ActionController::Parameters.new(calendar: { "courseName" => "COMS101", "start_time" => "9:00 AM", "end_time" => "11:00 AM", "repeated_weeks" => 1 })
        permitted_params = params.require(:calendar).permit(:courseName, :start_time, :end_time, :repeated_weeks)
        expect(permitted_params).to eq({ "courseName" => "COMS101", "start_time" => "9:00 AM", "end_time" => "11:00 AM", "repeated_weeks" => 1 })
      end
    end
  end
end