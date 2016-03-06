class Api::ResourcesController < ApplicationController
  def index
    @resources = current_user.resources
  end

  def show
    @resource = Resource.includes(:projects, :categories).find(params[:id])
  end

  def create
    @resource = current_user.resources.new(resource_params)

    if @resource.save
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
