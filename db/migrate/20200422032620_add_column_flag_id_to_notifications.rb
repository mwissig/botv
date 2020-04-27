class AddColumnFlagIdToNotifications < ActiveRecord::Migration[5.2]
  def change
            add_column :notifications, :flag_id, :integer
  end
end
