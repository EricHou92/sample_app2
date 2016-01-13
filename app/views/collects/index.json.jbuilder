json.array!(@collects) do |collect|
  json.extract! collect, :id, :user_id, :thing_id
  json.url collect_url(collect, format: :json)
end
