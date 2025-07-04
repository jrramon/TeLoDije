class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :title, presence: true, length: { minimum: 5, maximum: 200 }
  validates :question, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :resolution_date, presence: true
  validate :resolution_date_must_be_in_future, on: :create, unless: :skip_validation
  
  scope :active, -> { where(resolved: false) }
  scope :resolved, -> { where(resolved: true) }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }
  
  def total_votes
    votes.count
  end
  
  def yes_votes
    votes.where(outcome: true).sum(:points)
  end
  
  def no_votes
    votes.where(outcome: false).sum(:points)
  end
  
  def total_points
    yes_votes + no_votes
  end
  
  def yes_percentage
    return 0 if total_points == 0
    (yes_votes.to_f / total_points * 100).round(1)
  end
  
  def no_percentage
    return 0 if total_points == 0
    (no_votes.to_f / total_points * 100).round(1)
  end
  
  def can_be_voted_on?
    !resolved && resolution_date > Time.current
  end
  
  def should_resolve?
    resolution_date <= Time.current && !resolved
  end
  
  private
  
  def resolution_date_must_be_in_future
    if resolution_date.present? && resolution_date <= Time.current
      errors.add(:resolution_date, "debe ser en el futuro")
    end
  end
  
  def skip_validation
    @skip_validation
  end
  
  def skip_validation=(value)
    @skip_validation = value
  end
end 