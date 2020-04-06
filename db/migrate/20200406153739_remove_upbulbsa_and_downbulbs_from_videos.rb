class RemoveUpbulbsaAndDownbulbsFromVideos < ActiveRecord::Migration[5.2]
  def change
    remove_column :videos, :upbulbs, :integer
    remove_column :videos, :downbulbs, :integer
  end
end
