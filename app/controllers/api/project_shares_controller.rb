require 'byebug'
class Api::ProjectSharesController < ApplicationController
  def create
    share = ProjectShare.new(share_params)
    if current_user.id == share.project ? share.project.user_id : current_user.id
      if share.save
        render json: {msg: "share successful"}, status: 200
      else
        render json: share.errors, status: 422
      end
    else
      render json: {msg: "not your project"}, status: 422
    end
  end

  def destroy
    share = ProjectShare.find_by_id(params[:id])
    if share
      if current_user.id == share.project.user_id
        share.delete
        render json: {msg: "success"}, status: 200
      else
        render json: {msg: "not your project"}, status: 422
      end
    else
      render json: {msg: "does not exist"}, status: 422
    end
  end

  private
  def share_params
    params.require(:share).permit(:project_id, :user_id)
  end
end
