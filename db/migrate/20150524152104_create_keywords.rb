class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.integer :entry_id
      t.string :text
      t.decimal :relevance

      t.timestamps null: false
    end
  end
end
