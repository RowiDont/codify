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
        params[:project][:id].each do |id|
          ProjectResource.create({
            resource_id: @resource.id,
            project_id: id
          })
        end if params[:project][:id]
      end

      if params[:category]
        params[:category][:id].each do |id|
          CategoryResource.create({
            resource_id: @resource.id,
            category_id: id
          })
        end if params[:category][:id]
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
