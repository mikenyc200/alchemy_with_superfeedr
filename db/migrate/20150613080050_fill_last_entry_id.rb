class FillLastEntryId < ActiveRecord::Migration
  def change
    Notification.last.update :last_entry_id => Entry.last.id
  end
end
