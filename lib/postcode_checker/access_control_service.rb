# frozen_string_literal: true

module PostcodeChecker
  class AccessControlService
    def self.call(*args, &block)
      new(*args, &block).call
    end

    def initialize(postcode_string:, whitelist_file_path:)
      @postcode_string = postcode_string.gsub(' ', '')
      @whitelist_file_path = whitelist_file_path
    end

    def call
      return false unless valid_lsoa? || valid_postcode?

      true
    end

    private

    def postcode
      @postcode ||=
        begin
          PostcodeChecker::PostcodesIoApi.get(postcode: @postcode_string)
        rescue ArgumentError
          { 'result' => { 'lsoa' => '', 'postcode' => @postcode_string } }
        end
    end

    def whitelist
      @whitelist ||= YAML.safe_load(File.open(@whitelist_file_path, 'r'))
    end

    def valid_lsoa?
      return false unless check_lsoa(whitelist['lsoas'])

      true
    end

    def check_lsoa(lsoas)
      lsoas.any? { |lsoa| postcode['result']['lsoa'].match?(/#{lsoa}/i) }
    end

    def valid_postcode?
      return false unless check_postcode(whitelist['postcodes'])

      true
    end

    def check_postcode(postcodes)
      postcodes.any? do |whitelisted|
        postcode['result']['postcode'].gsub(' ', '').match(/#{whitelisted}/i)
      end
    end
  end
end
