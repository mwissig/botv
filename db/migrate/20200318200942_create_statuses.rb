class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.string :brief
      t.integer :rating
      t.text :long

      t.timestamps
    end
  end
end
