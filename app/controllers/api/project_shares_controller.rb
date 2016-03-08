require 'byebug'
class Api::ProjectSharesController < ApplicationController
  def create
    share = ProjectShare.new(project_share_params)
    if current_user.id == share.project.user_id
      if share.save
        render json: {msg: "share successful"}, status: 200
      else
        render json: {msg: "invalid share"}, status: 500
      end
    else
      render json: {msg: "not your project"}, status: 500
    end
  end

  def destroy
    share = ProjectShare.find_by_id(params[:id])
    if share
      if current_user.id == share.project.user_id
        share.delete
        render json: {msg: "success"}, status: 200
      else
        render json: {msg: "not your project"}, status: 500
      end
    else
      render json: {msg: "does not exist"}, status: 500
    end
  end

  private
  def project_share_params
    params.require(:project_share).permit(:project_id, :user_id)
  end
end
