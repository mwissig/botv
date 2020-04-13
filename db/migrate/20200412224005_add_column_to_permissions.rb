class AddColumnToPermissions < ActiveRecord::Migration[5.2]
  def change
    add_column :permissions, :is_horny, :boolean
  end
end
