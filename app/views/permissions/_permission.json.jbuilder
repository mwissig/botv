json.extract! permission, :id, :user_id, :is_admin, :is_mod, :can_post_video, :can_comment, :can_bulb, :video_ban_end, :comment_ban_end, :bulb_ban_end, :created_at, :updated_at
json.url permission_url(permission, format: :json)
