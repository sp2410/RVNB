class AdminNotificationsController < InheritedResources::Base

  private

    def admin_notification_params
      params.require(:admin_notification).permit()
    end
end

