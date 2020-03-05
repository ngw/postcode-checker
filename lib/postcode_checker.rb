# frozen_string_literal: true

Dir['./lib/postcode_checker/*.rb'].sort.each { |f| require f }

module PostcodeChecker
  VERSION = '0.1'
end
