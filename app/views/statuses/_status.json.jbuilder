json.extract! status, :id, :brief, :rating, :long, :created_at, :updated_at
json.url status_url(status, format: :json)
