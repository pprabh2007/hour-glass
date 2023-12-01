# spec/controllers/calendars_controller_spec.rb
require 'rails_helper'

RSpec.describe CalendarsController, type: :controller do
    let(:user) { User.create(name: "testProfessor", uni: "testProfessor", password: "testPassword") }
    let(:entitlements) { Entitlement.create({ uni: "testProfessor", courseName: "CSOR 4231", role: "Prof",created_at: DateTime.new(2023, 1, 1), updated_at: DateTime.new(2023, 1, 1) }) }
    let(:calendar) { Calendar.create(courseName: "CSOR 4231", start_time: DateTime.now, end_time: DateTime.now + 1.hour, repeated_weeks: 2, "location" => 
    "Zoom") }
  
    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(Entitlement).to receive(:where).with(uni: user.uni).and_return([entitlements])
    end

  describe 'DELETE #destroy' do
    let!(:calendar) { Calendar.create(courseName: "TestCourse", start_time: DateTime.now, end_time: DateTime.now + 1.hour, location: "Zoom") }

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
    let!(:calendar) { Calendar.create(courseName: "TestCourse", start_time: DateTime.now, end_time: DateTime.now + 1.hour, location: "Zoom") }

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

  describe 'GET #index' do
    let!(:calendar1) { Calendar.create(courseName: "CSOR 4231", start_time: DateTime.new(2023, 1, 8, 12), end_time: DateTime.new(2023, 1, 8, 12) + 1.hour, location: "Zoom") }
    let!(:calendar2) { Calendar.create(courseName: "COMS 4152", start_time: DateTime.new(2023, 1, 8, 14), end_time: DateTime.new(2023, 1, 8, 14) + 1.hour, location: "Zoom") }

    it 'generates the calendar for a specific week with a calendar event' do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      get :index, {:year => 2023, :month => 1, :day => 8 }

      # We expect there to be exactly 1 item
      expect(assigns(:calendars).length).to eq(1) # We have visibility for COMS 4152

      # We have visibility for COMS 4152
      expect(assigns(:calendars).first.courseName).to eq(calendar1.courseName)
      expect(assigns(:calendars).first.start_time).to eq(calendar1.start_time)
      expect(assigns(:calendars).first.end_time).to eq(calendar1.end_time)
      expect(assigns(:calendars).first.location).to eq(calendar1.location)
    end

    it 'generates the calendar for a week without calendars' do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      get :index, {:year => 2023, :month => 12, :day => 8 }
      expect(assigns(:calendars).empty?).to eq(true) # We do not have any calendars in this week
    end

    it 'generates the calendar for this week' do
      session[:user_name] = user.name
      session[:user_uni] = user.uni
      session[:user_password] = user.password
      get :index
    end
  end

  describe '#tFmt' do
    it 'formats DateTime in DT mode' do
      time = DateTime.parse('2023-01-01 12:00:00')
      formatted_time = controller.tFmt(time, 'DT')

      expect(formatted_time).to eq('01/01/2023 12:00')
    end

    it 'formats DateTime in D mode' do
      time = DateTime.parse('2023-01-01 12:00:00')
      formatted_time = controller.tFmt(time, 'D')

      expect(formatted_time).to eq('Jan 01 (Sunday)')
    end

    it 'formats DateTime in T mode' do
      time = DateTime.parse('2023-01-01 12:00:00')
      formatted_time = controller.tFmt(time, 'T')

      expect(formatted_time).to eq('12:00')
    end
  end

  describe '#edit_description' do
    let(:user) { User.create(name: "testProfessor", uni: "testProfessor", password: "testPassword") }
    let(:edit_a) { CalendarEdit.create(
                    courseName: "CSOR 4231", 
                    start_time: DateTime.now, 
                    end_time: DateTime.now + 1.hour, 
                    location: "Zoom",
                    user_id: 1,
                    edit_type: 'deletion',
                    update_time: DateTime.now ) }
    let(:edit_b) { CalendarEdit.create(
                        courseName: "CSOR 4231", 
                        start_time: DateTime.now, 
                        end_time: DateTime.now + 1.hour, 
                        location: "Zoom",
                        user_id: 1,
                        edit_type: 'update_addition',
                        update_time: DateTime.now ) }
    let(:edit_c) { CalendarEdit.create(
                            courseName: "CSOR 4231", 
                            start_time: DateTime.now, 
                            end_time: DateTime.now + 1.hour, 
                            location: "Zoom",
                            user_id: 1,
                            edit_type: 'update_deletion',
                            update_time: DateTime.now ) }
    it 'returns the correct description for deletion' do
      description = controller.edit_description(edit_a)
      expect(description).to include('[', user.uni, ']')
      expect(description).to include('Cancelling OH on')
    end

    it 'returns the correct description for update_addition' do
      description = controller.edit_description(edit_b)
      expect(description).to include('[', user.uni, ']')
      expect(description).to include('Conducting replacement OH on')
    end

    it 'returns the correct description for update_deletion' do
      description = controller.edit_description(edit_c)
      expect(description).to include('[', user.uni, ']')
      expect(description).to include('Not holding OH originally scheduled on')
    end
  end
end
