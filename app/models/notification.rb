class Notification < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :message, presence: true
  validates :notification_type, presence: true
  
  scope :unread, -> { where(read: false) }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_type, ->(type) { where(notification_type: type) }
  
  def mark_as_read!
    update!(read: true)
  end
  
  def mark_as_unread!
    update!(read: false)
  end
  
  def reference
    return nil unless reference_type && reference_id
    reference_type.constantize.find_by(id: reference_id)
  end
end 