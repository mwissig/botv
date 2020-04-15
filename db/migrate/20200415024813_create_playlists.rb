class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :category1
      t.string :category2
      t.string :tags
      t.integer :plays, :default => 0

      t.timestamps
    end
  end
end
