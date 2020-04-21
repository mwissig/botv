class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :playlist_id
      t.integer :sort, :default => 1
      t.integer :video_id

      t.timestamps
    end
  end
end
