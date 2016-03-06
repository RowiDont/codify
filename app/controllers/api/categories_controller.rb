require 'byebug'

class Api::CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
    render :index
  end

  def show
    @category = Category.includes(:resources, :projects).find(params[:id])
    render :show
  end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      render :show
    else
      render json: @category.errors, status: 422
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
