class Notification < ActiveRecord::Base

  def configuration_changed
    #delete old delayed jobs
    Delayed::Job.delete_all

    deliver_notification_job
  end

  def deliver_notification_job
    #deliver a mail now with the latest entries
    UserMailer.delay.notification(self.email , self.last_entry_id)

    #update last id of entry
    self.update(:last_entry_id => Entry.all.pluck(:id).max)

    #next job
    self.delay(:run_at => Time.now + self.frequency.minutes).deliver_notification_job
  end



end

