class AddValuesToNotifications < ActiveRecord::Migration
  def change
    Notification.create(:email => "vigneshp.ceg@gmail.com" , :frequency => "60")
  end
end
