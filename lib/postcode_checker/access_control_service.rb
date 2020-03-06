# frozen_string_literal: true

module PostcodeChecker
  class AccessControlService
    def self.call(*args, &block)
      new(*args, &block).call
    end

    def initialize(postcode:, whitelist_file_path:)
      @postcode = postcode
      @whitelist_file_path = whitelist_file_path
    end

    def call
      return false unless valid_lsoa? || valid_postcode?

      true
    end

    private

    def whitelist
      @whitelist ||= YAML.safe_load(File.open(@whitelist_file_path, 'r'))
    end

    def valid_lsoa?
      return false unless check_lsoa(whitelist['lsoas'])

      true
    end

    def check_lsoa(lsoas)
      lsoas.any? { |lsoa| @postcode['result']['lsoa'].match?(/#{lsoa}/i) }
    end

    def valid_postcode?
      return false unless check_postcode(whitelist['postcodes'])

      true
    end

    def check_postcode(postcodes)
      postcodes.any? do |postcode|
        @postcode['result']['postcode'].gsub(' ', '').match(/#{postcode}/i)
      end
    end
  end
end
