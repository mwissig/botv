class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :body
      t.integer :parent_id
      t.string :parent_type

      t.timestamps
    end
  end
end
