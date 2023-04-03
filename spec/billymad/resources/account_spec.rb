require 'spec_helper'

describe Billymad::Account do
  let(:attributes) { { first_name: 'John', last_name: 'Doe' } }
  let(:account)    { Billymad::Account.new(attributes) }

  include_examples 'can be initialized'

  it 'has correct #resource_name' do
    expect(account.send(:resource_name)).to eq('client')
  end

  it 'has correct #plural_resource_name' do
    expect(described_class.plural_resource_name).to eq('clients')
  end

  describe '.current' do
    it 'makes a GET request using the correct resource and id' do
      expect(Billymad::Request::Proxy).to receive(:get).with(described_class, { id: 'myself' }).and_return({})
      Billymad::Account.current
    end
  end
end
