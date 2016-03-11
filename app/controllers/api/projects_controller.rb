class Api::ProjectsController < ApplicationController
  def index
    @projects = current_user.projects
  end

  def create
    @project = current_user.projects.create(project_params)
    if @project.save
      render json: @project
    else
      render json: @project.errors, status: 422
    end
  end

  def show
    @project = Project.includes(:resources => :categories).find_by_id(params[:id])
    if @project
      render :show
    else
      render json: { errors: ["does not exist"] }, status: 404
    end
  end

  private
  def project_params
    params.require(:project).permit(:title, :description)
  end
end
