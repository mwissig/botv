json.extract! playlist, :id, :user_id, :title, :description, :category1, :category2, :tags, :plays, :created_at, :updated_at
json.url playlist_url(playlist, format: :json)
