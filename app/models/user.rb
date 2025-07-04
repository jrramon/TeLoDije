class User < ApplicationRecord
  has_secure_password
  
  has_many :predictions, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  # Follow relationships
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :follows, source: :followed
  has_many :reverse_follows, foreign_key: :followed_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :reverse_follows, source: :follower
  
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :points, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_correct_predictions, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_predictions, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :current_streak, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :best_streak, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  # Available avatars and titles
  AVATARS = %w[default wizard knight ninja robot dragon unicorn].freeze
  TITLES = %w[Novato Aprendiz Vidente Profeta Sabio Maestro Leyenda].freeze
  
  def total_predictions
    predictions.count
  end
  
  def correct_predictions
    predictions.joins(:votes).where(resolved: true, votes: { outcome: :outcome }).count
  end
  
  def accuracy_percentage
    return 0 if total_predictions == 0
    (correct_predictions.to_f / total_predictions * 100).round(1)
  end
  
  def earned_badges
    badges.order('user_badges.earned_at DESC')
  end
  
  def following?(other_user)
    followed_users.include?(other_user)
  end
  
  def follow(other_user)
    return false if self == other_user
    follows.create(followed: other_user)
  end
  
  def unfollow(other_user)
    follows.find_by(followed: other_user)&.destroy
  end
  
  def unread_notifications_count
    notifications.unread.count
  end
  
  def has_badge?(badge_name)
    badges.exists?(name: badge_name)
  end
  
  def award_badge(badge_name)
    badge = Badge.find_by(name: badge_name)
    return false unless badge
    
    user_badges.create(badge: badge) unless has_badge?(badge_name)
  end
  
  def award_points(amount, reason = nil)
    update(points: points + amount)
    # Could log the points transaction here
  end
  
  def update_stats
    update(
      total_predictions: total_predictions,
      total_correct_predictions: correct_predictions
    )
    update_title
    check_badges
  end
  
  def update_streak(correct)
    if correct
      new_streak = current_streak + 1
      update(
        current_streak: new_streak,
        best_streak: [best_streak, new_streak].max
      )
    else
      update(current_streak: 0)
    end
  end
  
  private
  
  def update_title
    new_title = case accuracy_percentage
                when 0..20 then 'Novato'
                when 21..40 then 'Aprendiz'
                when 41..60 then 'Vidente'
                when 61..80 then 'Profeta'
                when 81..90 then 'Sabio'
                when 91..95 then 'Maestro'
                else 'Leyenda'
                end
    
    update(title: new_title) if title != new_title
  end
  
  def check_badges
    # First prediction badge
    if total_predictions == 1
      award_badge('Primera Predicción')
    end
    
    # First victory badge
    if total_correct_predictions == 1
      award_badge('Primera Victoria')
    end
    
    # Streak badges
    case current_streak
    when 3
      award_badge('Racha de 3')
    when 5
      award_badge('Racha de 5')
    when 10
      award_badge('Racha de 10')
    end
    
    # Prophet badge
    if accuracy_percentage >= 80 && total_predictions >= 5
      award_badge('Profeta')
    end
    
    # Popular badge
    if predictions.joins(:votes).group(:id).having('COUNT(votes.id) > 50').exists?
      award_badge('Popular')
    end
  end
end 