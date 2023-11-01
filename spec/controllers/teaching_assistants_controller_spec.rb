require 'rails_helper'

RSpec.describe TeachingAssistantsController, type: :controller do
  describe "GET #index" do
    it "returns http redirect" do
      get :index
      expect(response).to have_http_status(302)
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