class NotificationsController < ApplicationController
  before_action :require_login
  before_action :set_notification, only: [:show, :mark_as_read]
  
  def index
    @notifications = current_user.notifications.recent.page(params[:page]).per(20)
  end
  
  def show
    @notification.mark_as_read! unless @notification.read?
    redirect_to @notification.reference if @notification.reference
  end
  
  def mark_as_read
    @notification.mark_as_read!
    redirect_back(fallback_location: notifications_path)
  end
  
  def mark_all_as_read
    current_user.notifications.unread.update_all(read: true)
    redirect_back(fallback_location: notifications_path, notice: 'Todas las notificaciones marcadas como leídas.')
  end
  
  private
  
  def set_notification
    @notification = current_user.notifications.find(params[:id])
  end
end 