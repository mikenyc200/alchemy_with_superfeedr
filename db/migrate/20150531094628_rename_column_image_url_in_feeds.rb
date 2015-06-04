class RenameColumnImageUrlInFeeds < ActiveRecord::Migration
  def change
    rename_column :entries , :image_url , :image
  end
end
