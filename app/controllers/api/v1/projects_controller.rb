module Api::V1
  class ProjectsController < ApplicationController
    def index
      # TODO: add includes to eager load other models
      render json: { projects: Project.all }
    end

    def create
      @project = Project.new(project_params)
      fetch_client

      if @project.save
        render json: { project: @project }, status: :created
      else
        @project.check_conclusion_date_errors(project_params[:conclusion_date])
        render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      @project = Project.find(params[:id])
      fetch_client if project_params[:client_id].present?

      if @project.update(project_params)
        render json: { project: @project }
      else
        @project.check_conclusion_date_errors(project_params[:conclusion_date])
        render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private
    def project_params
      params.require(:project).permit(:name, :conclusion_date, :client_id)
    end

    def fetch_client
      @project.client = Client.find_by_id(project_params[:client_id])
    end
  end
end
