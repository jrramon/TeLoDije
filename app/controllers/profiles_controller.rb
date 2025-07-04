class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @predictions = @user.predictions.includes(:votes, :category).order(created_at: :desc)
    @recent_predictions = @predictions.limit(5)
    @badges = @user.earned_badges
    @followers_count = @user.followers.count
    @following_count = @user.followed_users.count
    @is_following = logged_in? && current_user.following?(@user)
  end
end
