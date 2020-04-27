json.extract! notification, :id, :user_id, :body, :created_at, :updated_at
json.url notification_url(notification, format: :json)
