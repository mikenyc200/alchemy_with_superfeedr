class Entry < ActiveRecord::Base
  belongs_to :feed

  validates :atom_id, uniqueness: {scope: :feed_id}

  validates :url, uniqueness: true

  #validates :extracted_text, uniqueness: true

  has_many :concepts, dependent: :destroy

  has_many :keywords, dependent: :destroy

  default_scope {
    order('created_at DESC')
  }

  after_create :alchemy_extract


  #if image column is blank, fetch image from flickr based on concept
  def image_fetch_from_flickr
    FlickRaw.api_key = '96c82ca534eeab3d74281a1aedae776b'
    FlickRaw.shared_secret = 'e90308d64bf86353'
    results = flickr.photos.search(:tags => self.concepts.first.text)

    if results and results.first
      info = flickr.photos.getInfo(:photo_id => results.first.id)
      url = FlickRaw.url_b(info)

      self.update(:image => url)
    end

  end


  def alchemy_extract

    begin
      #sentiment analysis
      sentiment_response = AlchemyAPI.search(:sentiment_analysis, url: self.url)
      #text extraction
      t_response = AlchemyAPI.search(:text_extraction, url: self.url)

      #self.update(:sentiment => sentiment_response["type"], :sentiment_score => sentiment_response["score"])

      self.update(:sentiment => sentiment_response["type"], :sentiment_score => sentiment_response["score"], :extracted_text => HTMLEntities.new.decode(t_response))

      #concept tagging
      concept_response = AlchemyAPI.search(:concept_tagging, url: self.url)

      concept_response.each do |c|
        concepts.create(:text => c["text"], :relevance => c["relevance"])
      end

        #keyword extraction
        #keyword_response = AlchemyAPI.search(:keyword_extraction, url: self.url)

        #keyword_response.each do |c|
        #  keywords.create(:text => c["text"], :relevance => c["relevance"])
        #end
    rescue => e
      puts "Error in alchemy====>" + e.message
    end

    if self.image.blank?
      image_fetch_from_flickr
    end
  end

end
