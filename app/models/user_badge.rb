class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge
  
  validates :user_id, uniqueness: { scope: :badge_id, message: "ya tiene este badge" }
  validates :earned_at, presence: true
  
  before_validation :set_earned_at, on: :create
  
  private
  
  def set_earned_at
    self.earned_at ||= Time.current
  end
end 