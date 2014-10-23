json.array!(@portalmanager_mains) do |portalmanager_main|
  json.extract! portalmanager_main, :id
  json.url portalmanager_main_url(portalmanager_main, format: :json)
end
