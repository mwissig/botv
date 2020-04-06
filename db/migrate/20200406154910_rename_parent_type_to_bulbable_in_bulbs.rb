class RenameParentTypeToBulbableInBulbs < ActiveRecord::Migration[5.2]
  def change
            rename_column :bulbs, :parent_type, :bulbable_type
  end
end
