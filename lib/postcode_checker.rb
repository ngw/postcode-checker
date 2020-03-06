# frozen_string_literal: true

require 'yaml'

Dir[File.join(__dir__, '**/*.rb')].sort.each { |f| require f }

module PostcodeChecker
  VERSION = '0.1'
end
