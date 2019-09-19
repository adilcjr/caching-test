ActiveSupport::Notifications.subscribe "http_cache.faraday" do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  cache_status = event.payload[:cache_status]
  puts "Cache Status: #{cache_status}"
end