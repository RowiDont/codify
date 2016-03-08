class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      render :show
    else
      render json: @user.errors, status: 422
    end
  end

  def show
    @user = current_user
    if @user
      render :show
    else
      render json: "not logged in", status: 401
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
