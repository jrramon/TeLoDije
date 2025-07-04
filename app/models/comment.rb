class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prediction
  
  validates :content, presence: true, length: { minimum: 1, maximum: 1000 }
  
  scope :recent, -> { order(created_at: :desc) }
  
  after_create :notify_prediction_owner
  
  private
  
  def notify_prediction_owner
    return if user_id == prediction.user_id
    
    Notification.create!(
      user: prediction.user,
      title: "Nuevo comentario",
      message: "#{user.username} comentó en tu predicción: '#{prediction.title}'",
      notification_type: "comment",
      reference_id: id,
      reference_type: "Comment"
    )
  end
end 