class UserMailer < ActionMailer::Base
  default :from => "mikenyc@gmail.com"

  def notification(email_id,entry_id)
    @entries =  Entry.where("id > ?" , entry_id)
    mail(to: email_id, subject: "New Entries- #{@entries.count}")
  end

end
