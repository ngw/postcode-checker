# frozen_string_literal: true

ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

root = File.expand_path('..', __dir__)
require File.join(root, 'lib', 'postcode_checker')
