class AddExtractedTextToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :extracted_text, :text , :limit => 16777215
  end
end
