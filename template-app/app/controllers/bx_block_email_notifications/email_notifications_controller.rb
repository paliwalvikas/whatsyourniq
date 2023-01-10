module BxBlockEmailNotifications
  class EmailNotificationsController < ApplicationController
    def show
      email_notification = EmailNotification.joins(:notification).find_by(
        id: params[:id],
        notifications: {account_id: current_user.id}
      )

      if email_notification
        render json: EmailNotificationSerializer.new(email_notification).serializable_hash,
               status: :ok
      else
        render json: {errors: [{message: I18n.t('controllers.bx_block_email_notifications.email_notifications_controller.email_notification_not_found')},]}, status: :not_found
      end
    end

    def create
      notification = BxBlockNotifications::Notification.find_by(
        id: params[:notification_id],
        account_id: current_user.id
      )

      if notification
        email_notification = SendEmailNotificationService.new(notification).call

        render json: EmailNotificationSerializer.new(email_notification).serializable_hash,
               status: :ok
      else
        render json: {errors: [{message: I18n.t('controllers.bx_block_email_notifications.email_notifications_controller.email_notification_not_found')},]}, status: :not_found
      end
    end
  end
end
