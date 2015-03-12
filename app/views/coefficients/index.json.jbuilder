json.array!(@promotions) do |promotion|
  json.extract! promotion, :id, :quota, :bin, :legal_description
  json.url promotion_url(promotion, format: :json)
end
