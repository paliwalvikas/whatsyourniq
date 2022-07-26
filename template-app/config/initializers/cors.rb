Rails.application.config.middleware.insert_before 0, Rack::Cors do
  # allow do
  #   origins '*'
  #   resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
  # end
  allow do
    origins "https://ftprojectsearchengine-133842-react-native.b133842.dev.eastus.az.svc.builder.cafe"
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
  allow do
    origins "localhost:3000"
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
  allow do
    origins "https://ftprojectsearchengine-133842-react-native.b133842.stage.eastus.az.svc.builder.ai"
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
