class ChangeColumnsAgain < ActiveRecord::Migration
  def change
  change_column :entries, :sentiment_score , :decimal , :precision => 6 , :scale => 5
  change_column :concepts, :relevance , :decimal , :precision => 6 , :scale => 5

  end

end
