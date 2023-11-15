# spec/controllers/calendars_controller_spec.rb
require 'rails_helper'

RSpec.describe CalendarsController, type: :controller do
    let(:user) { User.create(name: "testProfessor", uni: "testProfessor", password: "testPassword") }
    let(:entitlements) { Entitlement.create({ uni: "testProfessor", courseName: "CSOR 4231", role: "Prof",
                                              created_at: DateTime.new(2023, 1, 1), updated_at: DateTime.new(2023, 1, 1) }) }
    let(:calendar) { Calendar.create(courseName: "CSOR 4231", start_time: DateTime.now, end_time: DateTime.now + 1.hour, repeated_weeks: 2) }
  
  
    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(Entitlement).to receive(:where).with(uni: user.uni).and_return([
      Entitlement.new(uni: user.uni, courseName: 'COMS 4152', role: 'Prof')
    ])
    end

  describe 'DELETE #destroy' do
    let!(:calendar) { Calendar.create(courseName: "TestCourse", start_time: DateTime.now, end_time: DateTime.now + 1.hour) }

    it 'destroys the calendar and redirects to edit_office_hour_teaching_assistants_path' do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      delete :destroy, {:id => calendar.id }
      expect(response).to redirect_to(edit_office_hour_teaching_assistants_path)
      expect(Calendar.find_by(id: calendar.id)).to be_nil
    end
  end

  describe 'GET #edit' do
    let!(:calendar) { Calendar.create(courseName: "TestCourse", start_time: DateTime.now, end_time: DateTime.now + 1.hour) }

    it 'renders the edit template' do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      get :edit, {:id => calendar.id }
      expect(response).to render_template(:edit)
    end

    it 'assigns the requested calendar to @calendar' do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      get :edit, {:id => calendar.id }
      expect(assigns(:calendar)).to eq(calendar)
    end
  end

  describe 'GET #next_week' do
    it 'redirects to the next week' do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      get :next_week, {:year => 2023, :month => 1, :day => 1 }
      expect(response).to redirect_to(calendars_path(year: 2023, month: 1, day: 8))
    end
  end

  describe 'GET #prev_week' do
    it 'redirects to the previous week' do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      get :prev_week, {:year => 2023, :month => 1, :day => 8 }
      expect(response).to redirect_to(calendars_path(year: 2023, month: 1, day: 1))
    end
  end
end
