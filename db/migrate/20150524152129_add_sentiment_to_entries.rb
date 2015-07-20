class AddSentimentToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :sentiment, :string
    add_column :entries, :sentiment_score, :decimal
  end
end
