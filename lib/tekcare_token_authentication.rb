class TekcareTokenAuthentication < Faraday::Middleware
  def call(env)
    env[:request_headers]["Authorization"] = 'fotonotes ec457d0a974c48d5685a7efa03d137dc8bbde7e3'
    @app.call(env)
  end
end
