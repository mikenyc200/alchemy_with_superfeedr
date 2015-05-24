class Entry < ActiveRecord::Base
  belongs_to :feed

  validates :atom_id, uniqueness: {scope: :feed_id}

  has_many :concepts, dependent: :destroy

  has_many :keywords, dependent: :destroy

  default_scope {
    order('created_at DESC')
  }

  after_create :alchemy_extract


  def alchemy_extract

    begin
      #sentiment analysis
      sentiment_response = AlchemyAPI.search(:sentiment_analysis, url: self.url)
      self.update(:sentiment => sentiment_response["type"], :sentiment_score => sentiment_response["score"])

      #concept tagging
      concept_response = AlchemyAPI.search(:concept_tagging, url: self.url)

      concept_response.each do |c|
        concepts.create(:text => c["text"], :relevance => c["relevance"])
      end

      #keyword extraction
      keyword_response = AlchemyAPI.search(:keyword_extraction, url: self.url)

      keyword_response.each do |c|
        keywords.create(:text => c["text"], :relevance => c["relevance"])
      end
    rescue => e
      puts "Error in alchemy====>" + e.message
    end

  end

end
