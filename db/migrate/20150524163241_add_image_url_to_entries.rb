class AddImageUrlToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :image_url, :string
  end
end
