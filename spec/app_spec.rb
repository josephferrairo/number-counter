# frozen_string_literal: true

require 'spec_helper'
require './app/app'

describe NumberCounter do
  describe 'my app' do
    it 'should return a json response with the quantity when an integer is passed through' do
      Array.new(20) { rand(1...100) }.each do |number|
        post '/', {number: number}.to_json
        body = last_response.body
        parsed_body = JSON.parse(body)
        value = redis.get(number.to_s)
        expect(parsed_body[number.to_s]).to eq(value.to_i)
        expect(parsed_body[number.to_s]).to_not eq(0)
      end
    end

    it 'should return a json response with the quantity when a string in the form of a number is passed through' do
      Array.new(20) { rand(1...100) }.each do |number|
        post '/', {number: number.to_s}.to_json
        body = last_response.body
        parsed_body = JSON.parse(body)
        value = redis.get(number.to_s)
        expect(parsed_body[number.to_s]).to eq(value.to_i)
        expect(parsed_body[number.to_s]).to_not eq(0)
      end
    end

    it 'will return an error if the input not a number' do
      ['a','b','c'].each do |number|
        post '/', {number: number.to_s}.to_json
        body = last_response.body
        parsed_body = JSON.parse(body)
        expect(parsed_body['message']).to eq('Not a valid input')
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
