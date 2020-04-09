class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.boolean :is_admin, default: false
      t.boolean :is_mod, default: false
      t.boolean :can_post_video, default: true
      t.boolean :can_comment, default: true
      t.boolean :can_bulb, default: true
      t.datetime :video_ban_end
      t.datetime :comment_ban_end
      t.datetime :bulb_ban_end

      t.timestamps
    end
  end
end
