class AddPlaycountToVideos < ActiveRecord::Migration[5.2]
  def change
        add_column :videos, :plays, :integer, :default => 0
  end
end
