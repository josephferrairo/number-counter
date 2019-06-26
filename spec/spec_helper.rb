# frozen_string_literal: true

require 'rspec'
require 'rack/test'

module RSpecMixin
  ENV['RACK_ENV'] = 'test'

  require File.expand_path '../../app/app.rb', __FILE__

  module RSpecMixin
    include Rack::Test::Methods
  end

  RSpec.configure { |c| c.include RSpecMixin }
end
