class Api::ResourcesController < ApplicationController
  def index
    @resources = current_user.resources
  end

  def show
    @resource = Resource.includes(:projects, :categories).find_by_id(params[:id])
    if @resource
      render :show
    else
      render json: { errors: ["does not exist"] }, status: 404
    end
  end

  def create
    @resource = current_user.resources.new(resource_params)

    if @resource.save
      if params[:project]
        ProjectResource.create({
          resource_id: @resource.id,
          project_id: params[:project][:id]
        }) if params[:project][:id]
      end

      render :show
    else
      render json: @resource.errors, status: 422
    end
  end

  private
  def resource_params
    params.require(:resource).permit(:link, :description)
  end
end
