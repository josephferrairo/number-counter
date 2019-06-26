# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.require

class NumberCounter < Sinatra::Base
  post '/' do
    user_choice = user_choice(request)
    increment = increment(user_choice)
    { user_choice => increment }.to_json
  end

  private

  def redis
    @redis ||= Redis.new
  end

  def user_choice(request)
    json_request = JSON.parse(request.body.read)
    json_request['number']
  end

  def increment(user_choice)
    redis.incr(user_choice)
  end
end
