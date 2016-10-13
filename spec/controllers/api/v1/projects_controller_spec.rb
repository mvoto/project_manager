require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do

  describe "GET #index" do
    before { get :index }

    it "returns http success" do
      get :index
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    context "fetching body" do
      let!(:conslog_project) { create(:project, name: "Conslog's Plan") }
      let!(:google_project) { create(:project, name: "Google's Plan") }
      let!(:apple_project) { create(:project, name: "Apple's Plan") }

      let(:body) { JSON.parse(response.body) }

      it 'renders correct project names' do
        get :index
        project_names = body.map{|project| project["name"] }

        expect(project_names).to match_array(
          ["Conslog's Plan", "Google's Plan", "Apple's Plan"]
        )
      end

      it 'returns expected projects count' do
        get :index
        expect(body.count).to eq(3)
      end
    end
  end

  describe "POST #create" do
    let(:client) { create(:client) }
    let(:project_params) do
      {
        project: {
          name: "New Project", client_id: client.id, conclusion_date: "2017/02/16"
        }
      }
    end

    it 'makes post request successfully' do
      post :create, params: project_params

      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it 'creates a project' do
      expect{ post :create, params: project_params }.to change{ Project.count }.by(1)
    end

    context 'given a non-existing client id' do
      let(:project_params) { { project: { name: '', client_id: 0 } } }
      let(:body) { JSON.parse(response.body) }

      it 'returns error code' do
        post :create, params: project_params

        expect(response.status).to eq(422)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders unexistent client error' do
        post :create, params: project_params

        expect(body["errors"]).to include("Client must exist")
      end
    end

    context 'given an invalid conclusion date' do
      let(:project_params) { { project: { client_id: client.id, conclusion_date: "1" } } }
      let(:body) { JSON.parse(response.body) }

      it 'returns error code' do
        post :create, params: project_params

        expect(response.status).to eq(422)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders unexistent client error' do
        post :create, params: project_params

        expect(body["errors"]).to include("Conclusion date is invalid")
      end
    end
  end

  describe "PUT/PATCH #update" do
    let(:project) { create(:project) }
    let(:project_params) do
      {
        id: project.id,
        project: { name: "Updated Project", conclusion_date: "2017/08/27" }
      }
    end

    it 'makes patch request successfully' do
      patch :update, params: project_params

      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'updates a project' do
      patch :update, params: project_params

      expect(project.reload.name).to eq("Updated Project")
    end

    context 'given a non-existing client id' do
      let(:project_params) { { id: project.id, project: { name: '', client_id: 0 } } }
      let(:body) { JSON.parse(response.body) }

      it 'returns error code' do
        patch :update, params: project_params

        expect(response.status).to eq(422)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders unexistent client error' do
        patch :update, params: project_params

        expect(body["errors"]).to include("Client must exist")
      end
    end

    context 'given an invalid conclusion date' do
      let(:project_params) { { id: project.id, project: { conclusion_date: "1" } } }
      let(:body) { JSON.parse(response.body) }

      it 'returns error code' do
        patch :update, params: project_params

        expect(response.status).to eq(422)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders unexistent client error' do
        patch :update, params: project_params

        expect(body["errors"]).to include("Conclusion date is invalid")
      end
    end
  end

  describe "PUT/PATCH #finish" do
    let(:project) { create(:project) }
    let(:project_params) { { id: project.id } }

    it 'makes patch request successfully' do
      patch :finish, params: project_params

      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'updates state and conclusion date' do
      Timecop.freeze(Date.today) do
        patch :finish, params: project_params

        expect(project.reload.state).to eq(Project::STATES.last)
        expect(project.reload.conclusion_date).to eq(Time.zone.now)
      end
    end
  end

  describe "PATCH #archive" do
    let(:fst_project) { create(:project) }
    let(:snd_project) { create(:project) }
    let(:project_params) { { ids: [fst_project.id, snd_project] } }

    it 'makes archive request successfully' do
      patch :archive, params: project_params

      expect(response.status).to eq(204)
      expect(response).to have_http_status(:no_content)
    end

    it 'archives the projects' do
      Timecop.freeze(Date.today) do
        patch :archive, params: project_params

        [fst_project, snd_project].each do |project|
          expect(project.reload.archived).to be_truthy
          expect(project.reload.archived_at).to eq(Time.zone.now)
        end
      end
    end

    context 'given only one project' do
      let(:project_params) { { ids: fst_project.id } }

      it 'makes archive request successfully' do
        patch :archive, params: project_params

        expect(response.status).to eq(204)
        expect(response).to have_http_status(:no_content)
      end

      it 'archives the project' do
        Timecop.freeze(Date.today) do
          patch :archive, params: project_params

          expect(fst_project.reload.archived).to be_truthy
          expect(fst_project.reload.archived_at).to eq(Time.zone.now)
        end
      end
    end
  end
end
