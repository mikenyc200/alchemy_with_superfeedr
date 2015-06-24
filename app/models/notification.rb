class Notification < ActiveRecord::Base

  def configuration_changed
    #delete old delayed jobs
    Delayed::Job.delete_all

    deliver_notification_job
  end

  def deliver_notification_job
    #deliver a mail now with the latest entries
    UserMailer.delay.notification(self.email, self.last_entry_id)
    #self.delay.send_mail

    #update last id of entry
    self.update(:last_entry_id => Entry.all.pluck(:id).max)

    #next job
    self.delay(:run_at => Time.now + self.frequency.minutes).deliver_notification_job
  end

  #def send_mail
  #  client = SendGrid::Client.new do |c|
  #    c.api_user = 'mike2nyc'
  #    c.api_key = 'YouShallNotPass99'
  #  end
  #
  #  @entries = Entry.where("id > ?", self.last_entry_id)
  #  mail = SendGrid::Mail.new do |m|
  #    m.to = self.email
  #    m.from = "mikenyc@gmail.com"
  #    m.subject = "New Entries - #{@entries.count}"
  #    m.html = "
  #    <table>
  #<thead>
  #<tr>
  #  <th>Image</th>
  #  <th>Article</th>
  #  <!-- <th>Image</th> -->
  #  <!-- <th>Sentiment</th> -->
  #  <th>Sentiment score</th>
  #  <th>Permalink</th>
  #</tr>
  #</thead>
  #
  #<tbody>"
  #
  #    @entries.each do |entry|
  #      m.html += "<tr>
  #      <td>"
  #
  #      if entry and entry.image and !entry.image.include? "flickr"
  #        m.html += "<img src=\" #{entry.image}\">"
  #      elsif entry and entry.image
  #        m.html += "<img src=\"#{ entry.image }\" style=\"width: 151px ;height: 151px ;\" >"
  #
  #        m.html += "<br>
  #    <span class=\"tiny\">flickr</span>
  #        <% end %>
  #      </td>
  #    <td> #{ActionController::Base.helpers.link_to entry.title, Rails.application.routes.url_helpers.analysis_entry_path(entry) } <br>
  #        <%#= link_to entry.feed.title, entry.feed %> <br>
  #     #{entry.created_at}
  #    </td>
  #      <!-- <td><%= entry.sentiment %></td> -->
  #                                            <td> "
  #
  #        if entry.sentiment_score and entry.sentiment_score >= 0
  #          $colorTemp = '#66CD00'
  #        else
  #          $colorTemp = '#FF0000'
  #        end
  #
  #        m.html += "<span style=\"color:#{$colorTemp}\"> #{entry.sentiment_score} </span></td>
  #      <td>#{ ActionController::Base.helpers.link_to "Permalink", entry.url }</td>
  #    </tr>
  #<% end %>
  #</tbody>
  #    </table>
  #    "
  #
  #
  #      end
  #    end
  #
  #
  #  end
  #
  #  puts client.send(mail)
  #end

end



