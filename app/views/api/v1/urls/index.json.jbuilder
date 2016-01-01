json.url do
  json.id rand(1000)
  json.(@url, :url, :title, :images)
end

