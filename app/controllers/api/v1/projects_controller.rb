module Api::V1
  class ProjectsController < ApplicationController
    def index
      # TODO: add includes to eager load other models here
      render json: { projects: Project.all }
    end

    def create
      project        = Project.new(project_params)
      project.client = Client.find_by_id(project_params[:client_id])

      if project.save
        render json: { project: project }, status: :created
      else
        project.check_conclusion_date_errors(project_params[:conclusion_date])
        render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private
    def project_params
      params.require(:project).permit(:name, :conclusion_date, :client_id)
    end
  end
end
