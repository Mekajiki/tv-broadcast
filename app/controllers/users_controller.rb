class UsersController < ApplicationController
  before_filter :set_program_filter

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params.require(:user).permit(:status))
    redirect_to users_path
  end
end
