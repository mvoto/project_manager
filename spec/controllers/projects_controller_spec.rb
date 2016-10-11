require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do

  describe "GET #index" do
    before { get :index }

    it "returns http success" do
      get :index
      expect(response.status).to eq 200
      expect(response).to have_http_status(:success)
    end

    context "fetching body" do
      let!(:conslog_project) { create(:project, name: "Conslog's Plan") }
      let!(:google_project) { create(:project, name: "Google's Plan") }
      let!(:apple_project) { create(:project, name: "Apple's Plan") }

      let(:body) { JSON.parse(response.body) }

      it 'renders correct project names' do
        get :index
        project_names = body["projects"].map{|project| project["name"] }

        expect(project_names).to match_array(
          ["Conslog's Plan", "Google's Plan", "Apple's Plan"]
        )
      end

      it 'returns expected projects count' do
        get :index
        expect(body["projects"].count).to eq(3)
      end
    end
  end

end
