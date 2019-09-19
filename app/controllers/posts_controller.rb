class PostsController < ApplicationController
  require 'uri'
  require 'net/http'

  def index
    cache_svc = CacheApiService.new(cached: true)
    response = cache_svc.get('posts', timeout: 1.seconds)
    puts "Status Code: #{response.status}"
    render json: response.body
  end
end
