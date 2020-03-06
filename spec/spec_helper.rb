# frozen_string_literal: true

require 'rack/test'
require 'vcr'

require './config/environment'

ENV['SINATRA_ENV'] = 'test'

VCR.configure do |vcr|
  vcr.cassette_library_dir = 'spec/cassettes'
  vcr.hook_into :webmock
  vcr.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include Rack::Test::Methods
end
