class FollowsController < ApplicationController
  before_action :require_login
  before_action :set_user_to_follow, only: [:create, :destroy]
  
  def create
    if current_user.follow(@user_to_follow)
      redirect_to profile_path(@user_to_follow), notice: "Ahora sigues a #{@user_to_follow.username}."
    else
      redirect_to profile_path(@user_to_follow), alert: "No se pudo seguir al usuario."
    end
  end
  
  def destroy
    if current_user.unfollow(@user_to_follow)
      redirect_to profile_path(@user_to_follow), notice: "Ya no sigues a #{@user_to_follow.username}."
    else
      redirect_to profile_path(@user_to_follow), alert: "No se pudo dejar de seguir al usuario."
    end
  end
  
  private
  
  def set_user_to_follow
    @user_to_follow = User.find(params[:user_id])
  end
end 