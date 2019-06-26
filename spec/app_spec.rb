# frozen_string_literal: true

require 'spec_helper'
require './app/app'

describe NumberCounter do
  describe 'my app' do
    it 'should gets a 200 from the /' do
      Array.new(20) { rand(1...100) }.each do |number|
        post '/', {number: number}.to_json
        body = last_response.body
        parsed_body = JSON.parse(body)
        value = redis.get(number.to_s)
        expect(parsed_body[number.to_s]).to eq(value.to_i)
        expect(parsed_body[number.to_s]).to_not eq(0)
      end
    end
  end

  def app
    NumberCounter
  end

  def redis
    @redis ||= Redis.new
  end
end
