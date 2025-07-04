class RankingsController < ApplicationController
  def index
    @top_predictors = User.joins(:predictions)
                          .group('users.id')
                          .order('COUNT(predictions.id) DESC')
                          .limit(10)
    
    @top_accuracy = User.where('total_predictions >= 3')
                        .order(Arel.sql('(CAST(total_correct_predictions AS FLOAT) / total_predictions) DESC'))
                        .limit(10)
    
    @top_points = User.order(points: :desc).limit(10)
    
    @top_streaks = User.where('best_streak > 0')
                       .order(best_streak: :desc)
                       .limit(10)
    
    @recent_badges = UserBadge.includes(:user, :badge)
                              .order(earned_at: :desc)
                              .limit(10)
  end
end
