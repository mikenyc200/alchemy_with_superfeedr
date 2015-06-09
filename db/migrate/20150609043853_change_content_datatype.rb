class ChangeContentDatatype < ActiveRecord::Migration
  def change
    change_column :entries , :content , :text , :limit => 65536
  end
end
