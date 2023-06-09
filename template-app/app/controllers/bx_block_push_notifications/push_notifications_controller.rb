module BxBlockPushNotifications
  class PushNotificationsController < ApplicationController

    def index
      push_notifications = current_user.push_notifications
      if push_notifications.present?
        serializer = BxBlockPushNotifications::PushNotificationSerializer.new(
          push_notifications
        )
        render json: serializer.serializable_hash, status: :ok
      else
        render json: {
          errors: I18n.t('controllers.bx_block_push_notifications.push_notifications_controller.there_is_no_push')
        }, status: :not_found
      end
    end

    def create
      push_notification = BxBlockPushNotifications::PushNotification.new(
        push_notifications_params.merge({account_id: current_user.id})
      )
      if push_notification.save
        serializer = BxBlockPushNotifications::PushNotificationSerializer.new(push_notification)
        render json: serializer.serializable_hash, status: :ok
      else
        render json: {
          errors: [{
              push_notification: push_notification.errors.full_messages
          }]
        }, status: :unprocessable_entity
      end
    rescue Exception => push_notification
      render json: {errors: [{push_notification: push_notification.message}]},
        status: :unprocessable_entity
    end

    def update
      push_notification = BxBlockPushNotifications::PushNotification.find_by(
        id: params[:id], push_notificable_id: current_user.id
      )
      return render json: { message: I18n.t('controllers.bx_block_push_notifications.push_notifications_controller.not_found') },
        status: :not_found if push_notification.blank?

      if push_notification.update(push_notifications_params)
        serializer = BxBlockPushNotifications::PushNotificationSerializer.new(push_notification)
        render json: serializer.serializable_hash,
          status: :ok
      else
        render json: { errors: [{push_notification: push_notification.errors.full_messages}]},
          status: :unprocessable_entity
      end
    rescue Exception => push_notification
      render json: {errors: [{push_notification: push_notification.message}]},
        status: :unprocessable_entity
    end

    def show
      push_notification = current_user.push_notifications.find(params[:id])

      if push_notification.blank?
        render json: { message: I18n.t('controllers.bx_block_push_notifications.push_notifications_controller.push_notification_not_found') },
        status: :not_found
      else
        render json: BxBlockPushNotifications::PushNotificationSerializer.new(push_notification)
      end
    end

    private

    def push_notifications_params
      params.require(:data)[:attributes].permit(
        :push_notificable_id,
        :push_notificable_type,
        :remarks, :is_read
      )
    end
  end
end
