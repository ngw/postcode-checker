# frozen_string_literal: true

describe PostcodeChecker::AccessControlService do
  let(:service) do
    described_class.call(
      postcode: postcode, whitelist_file_path: whitelist_file_path
    )
  end

  context 'when within service area LSOA' do
    let(:postcode) do
      { 'status' => 200,
        'result' => {
          'lsoa' => 'Tower Hamlets 031A',
          'postcode' => 'AAA 012'
        } }
    end
    let(:whitelist_file_path) do
      File.join(__dir__, '../fixtures', 'whitelist.yaml')
    end

    it 'is truthful' do
      expect(service).to be_truthy
    end
  end

  context 'when within service area postcodes' do
    let(:postcode) do
      { 'status' => 200,
        'result' => {
          'lsoa' => 'Whatever',
          'postcode' => 'E14 3QE'
        } }
    end
    let(:whitelist_file_path) do
      File.join(__dir__, '../fixtures', 'whitelist.yaml')
    end

    it 'is truthful' do
      expect(service).to be_truthy
    end
  end

  context 'when outside service area' do
    let(:postcode) do
      { 'status' => 200,
        'result' => {
          'lsoa' => 'Whatever',
          'postcode' => 'AAA 012'
        } }
    end
    let(:whitelist_file_path) do
      File.join(__dir__, '../fixtures', 'whitelist.yaml')
    end

    it 'is untruthful' do
      expect(service).to be_falsey
    end
  end
end
