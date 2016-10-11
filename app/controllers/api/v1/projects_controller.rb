module Api::V1
  class ProjectsController < ApplicationController
    def index
      # TODO: add includes to eager load other models here
      render json: { projects: Project.all }
    end
  end
end
