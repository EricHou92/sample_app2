json.array!(@things) do |thing|
  json.extract! thing, :id, :title, :depreciation_rate, :price, :style, :description, :commission, :delivery, :erasure, :user_id
  json.url thing_url(thing, format: :json)
end
