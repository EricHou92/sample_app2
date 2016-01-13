json.array!(@comments) do |comment|
  json.extract! comment, :id, :rating, :content, :user_id, :thing_id
  json.url comment_url(comment, format: :json)
end
