class RenameParentToBulbableInBulbs < ActiveRecord::Migration[5.2]
  def change
        rename_column :bulbs, :parent_id, :bulbable_id
  end
end
