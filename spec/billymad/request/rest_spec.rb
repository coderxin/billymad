require "spec_helper"

describe Billymad::Request::Rest do

  subject { described_class }

  let(:config) do 
    double(:config, 
      api_url: 'http://example.test', 
      api_format: :json, 
      api_key: 'key',
      logger: FakeLogger.new(STDOUT)
    )
  end
  
  it { should respond_to(:call) }

  describe "::EXCEPTIONS" do
    it { should be_const_defined(:EXCEPTIONS) }
    it "contains correct exception classes" do
      expect(subject::EXCEPTIONS).to match_array([ 
        RestClient::ResourceNotFound, 
        RestClient::Unauthorized, 
        RestClient::Forbidden 
      ])
    end
  end

  describe '.call' do
    it 'makes a GET request to resource using correct parameters' do
      rest_client = double(:rest_client)
      rest_client_response = double(:resource, get: {})

      rest_client.stub(:[]).with('users').and_return(rest_client_response)
      rest_client_response.should_receive(:get).with({ something: 'ABC' }).and_return({})

      described_class.should_receive(:api).and_return(rest_client)
      described_class.call(:get, 'users', { something: 'ABC' })
    end

    it 'handles exceptions and returns nil' do
      described_class.should_receive(:api).and_raise(RestClient::ResourceNotFound)
      described_class.should_receive(:log)
      expect(described_class.call(:get, 'dogs', { something: 'ABC' })).to be_nil
    end
  end


  describe '.api' do
    it 'holds RestClient::Resource instance' do
      subject.should_receive(:config).any_number_of_times.and_return(config)
      expect(subject.send(:api)).to be_a(RestClient::Resource)      
    end
  end

  describe '.auth_headers' do
    it 'sets correct authentication headers' do
      subject.should_receive(:config).any_number_of_times.and_return(config)
      expect(subject.send(:auth_headers)).to eq({ 
        'Accept' => 'application/json', 
        'Content-Type' => 'application/json', 
        'X-BillomatApiKey' => 'key'
      })
    end
  end

  describe '.content_type' do
    it 'sets correct content_type' do
      expect(subject.send(:content_type)).to eq("application/json")
    end
  end

  describe '.config' do
    it 'holds Billymad::Configuration instance' do
      expect(subject.send(:config)).to be_a(Billymad::Configuration)
    end
  end

  describe '.log' do
    it 'builds correct log message' do
      exception = double(:exception, message: '404 Resource Not Found')
      subject.should_receive(:config).and_return(config)
      config.logger.should_receive(:info).with("[get] Resource: clients/123 Params: {} Error: 404 Resource Not Found")
      subject.send(:log, exception, :get, 'clients/123', {})
    end
  end
end