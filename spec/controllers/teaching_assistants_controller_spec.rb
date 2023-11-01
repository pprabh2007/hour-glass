require 'rails_helper'

RSpec.describe TeachingAssistantsController, type: :controller do
  describe "GET #index" do
    it "returns http redirect" do
      get :index
      expect(response).to have_http_status(302)
    end
  end

  describe "private #teaching_assistant_params" do
  it "permits the correct parameters" do
    params = ActionController::Parameters.new(teaching_assistant: { name: "John Doe", uni: "jd123", class_id: "COMS101" })
    permitted_params = params.require(:teaching_assistant).permit(:name, :uni, :class_id).to_h.symbolize_keys

    expect(permitted_params).to eq({ name: "John Doe", uni: "jd123", class_id: "COMS101" })
  end
end

describe 'POST #create' do
  context 'with valid parameters' do
    it 'creates a new teaching assistant' do
      post :create, { :name => 'John Doe', :uni => 'jd123', :class_id => 'COMS101' }
      expect(response).not_to render_template(:new)
    end
  end

  context 'with invalid parameters' do
    it 'does not create a new teaching assistant' do
      expect {
        post :create, params: { teaching_assistant: { name: '', uni: '', class_id: '' } }
      }.not_to change(TeachingAssistant, :count)
    end
  end
end

describe "private #calendar_params" do
    it "permits the correct parameters" do
      params = ActionController::Parameters.new(calendar: { "class_id" => "COMS101", "start_time" => "9:00 AM", "end_time" => "11:00 AM", "teaching_assistant_id" => 1 })
      permitted_params = params.require(:calendar).permit(:class_id, :start_time, :end_time, :teaching_assistant_id)

      expect(permitted_params).to eq({ "class_id" => "COMS101", "start_time" => "9:00 AM", "end_time" => "11:00 AM", "teaching_assistant_id" => 1 })
    end
  end

end