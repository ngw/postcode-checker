# frozen_string_literal: true

describe PostcodeChecker, :vcr do
  it { expect(described_class::VERSION).to eq('0.1') }

  def app
    PostcodeChecker::Web
  end

  context 'when visiting /' do
    before do
      get '/'
    end

    it 'responds with a 200' do
      expect(last_response).to be_ok
    end

    it 'responds with a form' do
      expect(last_response.body).to match(/<form id='postcode-checker'/)
    end
  end

  context 'when posting to /check a postcode within service area' do
    before do
      post '/check', { postcode: postcode }
    end

    describe 'not within service area' do
      let(:postcode) { 'e143qe' }

      it 'responds with a 200' do
        expect(last_response).to be_ok
      end

      it 'responds with a negative result' do
        expect(last_response.body).to match(/is not within our service area/)
      end
    end

    describe 'within service area' do
      let(:postcode) { 'SH241AA' }

      it 'responds with a 200' do
        expect(last_response).to be_ok
      end

      it 'responds with a negative result' do
        expect(last_response.body).to match(/is within our service area/)
      end
    end
  end
end
