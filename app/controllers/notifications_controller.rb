class NotificationsController < ApplicationController
  def configure
    @notification = Notification.first
  end

  def update
    @notification = Notification.find(params[:notification][:id])
    @notification.update(:email => params[:notification][:email] , :frequency => params[:notification][:frequency])

    #update delivery time in delayed job
    @notification.configuration_changed

    @notice = "Successfully updated"

    render "notifications/configure"
  end


end
