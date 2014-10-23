json.array!(@portalmanager_appdefs) do |portalmanager_appdef|
  json.extract! portalmanager_appdef, :id
  json.url portalmanager_appdef_url(portalmanager_appdef, format: :json)
end
