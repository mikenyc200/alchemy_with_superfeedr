require 'digest/md5'

class Feed < ActiveRecord::Base

  has_many :entries, dependent: :destroy

  validates :url, uniqueness: true


  def secret
    Digest::MD5.hexdigest(created_at.to_s)
  end

  def notified params
    begin
      update_attributes(:status => params["status"]["http"])

      params['items'].each do |i|
        url_temp =  i["permalinkUrl"]
        #make permalink unique and discard permalinks with redirect
        next if Entry.all.pluck(:url).include? url_temp or  url_temp.include? "redirect"
        entries.create(:atom_id => i["id"], :title => HTMLEntities.new.decode(i["title"]), :url => i["permalinkUrl"], :image => extract_image(i), :content => i["content"])
      end
    rescue => e
      logger.error e.message
    end
  end

  def extract_image(resp)

    begin
      resp["standardLinks"].each do |l, v|
        h = v[0]
        next if h["type"].blank? or !h["type"].include? "image"
        return h["href"]
      end

    rescue => e
      logger.error e.message
      return nil
    end

    return nil
  end

end
