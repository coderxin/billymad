require 'spec_helper'

describe Billymad::Configuration do
  let(:configuration) { Billymad::Configuration.new }

  it { should respond_to(:billomat_id) }
  it { should respond_to(:api_key) }
  it { should respond_to(:api_format) }
  it { should respond_to(:secure) }
  it { should respond_to(:api_url) }
  it { should respond_to(:logger) }

  it { should_not respond_to(:protocol) }
  it { should_not respond_to(:billomat_url) }
  it { should_not respond_to(:billomat_host) }

  describe '#api_url' do
    it 'is verifying configuration' do
      expect(configuration).to receive(:_verify_configuration)
      configuration.api_url
    end

    it 'uses correct url format' do
      configuration.billomat_id = 'my-id'
      configuration.api_key = 'something'
      configuration.secure = false

      expect(configuration.api_url).to eq('http://my-id.billomat.net/api/')
    end

    it 'raises exception when billomat ID is not set' do
      configuration.billomat_id = nil
      expect do
        configuration.api_url
      end.to raise_error(Billymad::ConfigurationError)
    end

    it 'raises exception when Api key is not set' do
      configuration.billomat_id = 'id'
      configuration.api_key = nil
      expect do
        configuration.api_url
      end.to raise_error(Billymad::ConfigurationError)
    end
  end

  describe '#billomat_host' do
    it 'holds default billomat host address' do
      expect(configuration.send(:billomat_host)).to eq('billomat.net')
    end
  end

  describe '#protocol' do
    it 'uses https protocol' do
      configuration.secure = true
      expect(configuration.send(:protocol)).to eq('https')
    end

    it 'uses http protocol' do
      configuration.secure = false
      expect(configuration.send(:protocol)).to eq('http')
    end
  end
end
