require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :controller do
  describe "POST #create" do
    let(:project) { create(:project) }
    let(:note_params) do
      {
        note: { content: "This a new note", project_id: project.id }
      }
    end

    it 'makes post request successfully' do
      post :create, params: note_params

      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it 'creates a note' do
      expect{ post :create, params: note_params }.to change{ Note.count }.by(1)
    end

    context 'given a non-existing project id' do
      let(:note_params) { { note: { content: '', project_id: 0 } } }
      let(:body) { JSON.parse(response.body) }

      it 'returns error code' do
        post :create, params: note_params

        expect(response.status).to eq(422)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders unexistent project error' do
        post :create, params: note_params

        expect(body["errors"]).to include("Project must exist")
      end
    end
  end

  describe "DELETE #destroy" do
    let(:note) { create(:note) }
    let(:note_params) { { id: note.id } }

    it 'makes delete request successfully' do
      delete :destroy, params: note_params

      expect(response.status).to eq(204)
      expect(response).to have_http_status(:no_content)
    end

    it 'archives the note' do
      Timecop.freeze(Date.today) do
        delete :destroy, params: note_params

        expect(note.reload.archived).to be_truthy
        expect(note.reload.archived_at).to eq(Time.zone.now)
      end
    end
  end
end
