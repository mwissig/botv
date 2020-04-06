class CreateBulbs < ActiveRecord::Migration[5.2]
  def change
    create_table :bulbs do |t|
      t.integer :user_id
      t.integer :parent_id
      t.string :color
      t.string :parent_type

      t.timestamps
    end
  end
end
