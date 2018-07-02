class UsersController < ApplicationController
  def profile
    @phrases = current_user.phrases.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.friendly.find(params[:id])
    @phrases = @user.phrases
  end

  def index
    @users = User.includes(:phrases).paginate(page: params[:page], per_page: 10)
  end
end
