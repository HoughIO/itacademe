json.array!(@articles) do |article|
  json.extract! article, :title, :body, :date_published
  json.url article_url(article, format: :json)
end
