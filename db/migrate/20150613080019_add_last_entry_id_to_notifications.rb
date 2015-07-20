class AddLastEntryIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :last_entry_id, :integer
  end
end
