json.extract! video, :id, :user_id, :id_code, :provider, :title, :duration, :description, :thumbnail, :embed_url, :embed_code, :tags, :category1, :category2, :upbulbs, :downbulbs, :created_at, :updated_at
json.url video_url(video, format: :json)
