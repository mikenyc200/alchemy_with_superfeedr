class ChangeConceptsDecimal < ActiveRecord::Migration
  def change
   change_column :concepts , :relevance ,:decimal , :scale => 1 , :precision => 5
  end
end
