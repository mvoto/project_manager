module Api::V1
  class NotesController < ApplicationController
    def create
      @note = Note.new(note_params)
      fetch_project

      if @note.save
        render json: { project: @note }, status: :created
      else
        render json: { errors: @note.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @note = Note.find(params[:id])
      @note.soft_delete

      render json: { note: @note }, status: :no_content
    end

    private
    def note_params
      params.require(:note).permit(:content, :project_id)
    end

    def fetch_project
      @note.project = Project.find_by_id(note_params[:project_id])
    end
  end
end
