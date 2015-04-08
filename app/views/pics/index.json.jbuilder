json.array!(@pics) do |pic|
  json.extract! pic, :id, :title, :details
  json.url pic_url(pic, format: :json)
end
