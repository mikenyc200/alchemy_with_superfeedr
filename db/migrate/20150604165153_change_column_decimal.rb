class ChangeColumnDecimal < ActiveRecord::Migration
  def change
   change_column :entries,:sentiment_score,:decimal , :scale => 1 , :precision => 5
  end
end
