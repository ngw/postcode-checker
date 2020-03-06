# frozen_string_literal: true

describe PostcodeChecker::AccessControlService, :vcr do
  let(:service) do
    described_class.call(
      postcode_string: postcode_string, whitelist_file_path: whitelist_file_path
    )
  end

  context 'when within service area LSOA' do
    let(:postcode_string) { 'e143qp' }
    let(:whitelist_file_path) do
      File.join(__dir__, '../fixtures', 'whitelist.yaml')
    end

    it 'is truthful' do
      expect(service).to be_truthy
    end
  end

  context 'when within service area postcodes' do
    let(:postcode_string) { 'E1 0ND' }
    let(:whitelist_file_path) do
      File.join(__dir__, '../fixtures', 'whitelist.yaml')
    end

    it 'is truthful' do
      expect(service).to be_truthy
    end
  end

  context 'when explicitely whitelisted' do
    let(:postcode_string) { 'AAA 012' }
    let(:whitelist_file_path) do
      File.join(__dir__, '../fixtures', 'whitelist.yaml')
    end

    it 'is truthful' do
      expect(service).to be_truthy
    end
  end

  context 'when not in whitelist' do
    let('postcode_string') { 'XYZ 210' }
    let(:whitelist_file_path) do
      File.join(__dir__, '../fixtures', 'whitelist.yaml')
    end

    it 'is untruthful' do
      expect(service).to be_falsey
    end
  end
end
