json.extract! comment, :id, :user_id, :body, :parent_id, :parent_type, :created_at, :updated_at
json.url comment_url(comment, format: :json)
