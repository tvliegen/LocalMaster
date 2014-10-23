json.array!(@login_mains) do |login_main|
  json.extract! login_main, :id
  json.url login_main_url(login_main, format: :json)
end
