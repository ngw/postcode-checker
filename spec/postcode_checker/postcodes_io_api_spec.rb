# frozen_string_literal: true

describe PostcodeChecker::PostcodesIoApi, :vcr do
  let(:response) { described_class.get(postcode: postcode) }

  context 'when successful' do
    let(:postcode) { 'e143qe' }

    it 'returns 200' do
      puts 'ciao'
      expect(response['status']).to eq(200)
    end

    it 'has an LSOA' do
      expect(response['result']['lsoa']).to match(/Tower Hamlets/)
    end
  end

  context 'when unsuccessful' do
    let(:postcode) { 'madeup' }

    it 'raises ArgumentError' do
      expect { response }.to raise_error(ArgumentError)
    end

    it 'has a proper error message' do
      expect { response }.to raise_error("#{postcode} not found")
    end
  end
end
