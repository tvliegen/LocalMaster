json.array!(@usermanagement_users) do |usermanagement_user|
  json.extract! usermanagement_user, :id
  json.url usermanagement_user_url(usermanagement_user, format: :json)
end
