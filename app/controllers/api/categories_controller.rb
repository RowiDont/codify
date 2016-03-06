class Api::CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
    render :index
  end

  def show
    @category = Category.includes(:resources, :projects).find(params[:id])
    render :show
  end
end
