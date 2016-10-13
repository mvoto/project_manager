module Api::V1
  class ProjectsController < ApplicationController
    before_action :fetch_project, only: [:update, :finish]

    def index
      render json: Project.all
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
      fetch_client if project_params[:client_id].present?

      if @project.update(project_params)
        render json: { project: @project }
      else
        @project.check_conclusion_date_errors(project_params[:conclusion_date])
        render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def archive
      projects = Project.where(id: params[:ids])
      projects.map(&:soft_delete)

      render status: :no_content
    end

    def finish
      @project.mark_as_finished
      render json: { project: @project }
    end

    private
    def project_params
      params.require(:project).permit(:name, :conclusion_date, :client_id)
    end

    def fetch_client
      @project.client = Client.find_by_id(project_params[:client_id])
    end

    def fetch_project
      @project = Project.find(params[:id])
    end
  end
end
