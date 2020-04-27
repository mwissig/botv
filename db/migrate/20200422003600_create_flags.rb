class CreateFlags < ActiveRecord::Migration[5.2]
  def change
    create_table :flags do |t|
      t.integer :user_id
      t.integer :flaggable_id
      t.string :flaggable_type
      t.string :reason
      t.string :message

      t.timestamps
    end
  end
end
