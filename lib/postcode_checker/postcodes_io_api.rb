# frozen_string_literal: true

module PostcodeChecker
  class PostcodesIoApi
    class << self
      URI = 'https://api.postcodes.io/postcodes'

      def get(postcode:)
        response = client.get("#{URI}/#{postcode}")
        raise ArgumentError, "#{postcode} not found" unless response.success?

        Oj.load(response.body)
      end

      def client
        Faraday.new(
          headers: {
            'Content-Type': 'application/json',
            'User-Agent': 'postcode_checker/v1'
          }
        )
      end
    end

    private_class_method :client
  end
end
