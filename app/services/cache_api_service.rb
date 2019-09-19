class CacheApiService
  require 'active_support'
  require 'faraday'
  require 'faraday-http-cache'

  def initialize(cached: true)
    @connection = Faraday.new('https://jsonplaceholder.typicode.com/') do |conn|
      if cached
        conn.use  :http_cache, 
                  shared_cache: false,
                  store: Rails.cache,
                  serializer: Marshal,
                  logger: ActiveSupport::Logger.new(STDOUT),
                  instrumenter: ActiveSupport::Notifications
      end
      conn.adapter Faraday.default_adapter
    end
  end

  def get(method, params = {})
    start_time = Time.now

    response = @connection.get do |request|
      request.url(method, params)
    end

    time_taken_ms = (Time.now - start_time) * 1000
    puts "Time taken: #{time_taken_ms.round(3)}"

    response
  end
end
