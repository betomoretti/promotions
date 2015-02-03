json.array!(@airlines) do |airline|
  json.extract! airline, :id, :name
  json.url airline_url(airline, format: :json)
end
