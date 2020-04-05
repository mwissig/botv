class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.integer :user_id
      t.string :id_code
      t.string :provider
      t.string :title
      t.integer :duration
      t.text :description
      t.string :thumbnail
      t.string :embed_url
      t.string :embed_code
      t.string :tags
      t.string :category1
      t.string :category2
      t.integer :upbulbs
      t.integer :downbulbs

      t.timestamps
    end
  end
end
