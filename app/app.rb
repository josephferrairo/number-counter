# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.require

class NumberCounter < Sinatra::Base
  post '/' do
    user_choice = user_choice(request)
    increment = increment(user_choice)

    if an_integer?(user_choice) || a_number?(user_choice)
      { user_choice => increment }.to_json
    else
      { 'message': 'Not a valid input' }.to_json
    end
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

  def an_integer?(user_choice)
    user_choice.is_a?(Integer)
  end

  def a_number?(user_choice)
    user_choice =~ /\A[-+]?[0-9]+\z/
  end
end
