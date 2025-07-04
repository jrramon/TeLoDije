class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  
  validates :follower_id, uniqueness: { scope: :followed_id }
  validate :cannot_follow_self
  
  after_create :notify_followed
  
  private
  
  def cannot_follow_self
    if follower_id == followed_id
      errors.add(:base, "No puedes seguirte a ti mismo")
    end
  end
  
  def notify_followed
    Notification.create!(
      user: followed,
      title: "Nuevo seguidor",
      message: "#{follower.username} empezó a seguirte",
      notification_type: "follow",
      reference_id: follower_id,
      reference_type: "User"
    )
  end
end 