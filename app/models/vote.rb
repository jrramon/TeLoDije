class Vote < ApplicationRecord
  belongs_to :prediction
  belongs_to :user
  
  validates :outcome, inclusion: { in: [true, false] }
  validates :points, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
  validate :user_has_enough_points
  validate :prediction_can_be_voted_on
  validate :user_can_only_vote_once_per_prediction
  
  after_create :deduct_points_from_user
  after_destroy :return_points_to_user
  
  private
  
  def user_has_enough_points
    return unless user && points
    if user.points < points
      errors.add(:points, "no tienes suficientes puntos")
    end
  end
  
  def prediction_can_be_voted_on
    return unless prediction
    unless prediction.can_be_voted_on?
      errors.add(:prediction, "esta predicción ya no puede ser votada")
    end
  end
  
  def user_can_only_vote_once_per_prediction
    return unless user && prediction
    existing_vote = Vote.where(user: user, prediction: prediction).where.not(id: id).first
    if existing_vote
      errors.add(:user, "ya has votado en esta predicción")
    end
  end
  
  def deduct_points_from_user
    user.update(points: user.points - points)
  end
  
  def return_points_to_user
    user.update(points: user.points + points)
  end
end 