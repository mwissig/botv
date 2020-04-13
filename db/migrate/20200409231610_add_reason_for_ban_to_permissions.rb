class AddReasonForBanToPermissions < ActiveRecord::Migration[5.2]
  def change
        add_column :permissions, :reason_for_ban, :string
  end
end
