require "spec_helper"

describe Billymad::Request::Info do
  let(:resource) { double(:resource, resource_name: 'client', plural_resource_name: 'clients') }
  subject { described_class.new(resource, method: :get) }

  it { should respond_to(:method) }
  it { should respond_to(:resource_name) }
  it { should respond_to(:plural_resource_name) }
  it { should respond_to(:url) }
  it { should respond_to(:parameters) }

  describe '#resource_name' do
    it 'returns correct resource name' do
      expect(subject.resource_name).to eq('client')
    end
  end

  describe '#plural_resource_name' do
    it 'returns correct plural resource name' do
      expect(subject.plural_resource_name).to eq('clients')
    end
  end

  describe '#url' do
    context 'when GET without resource id' do
      it 'returns correct resource url' do
        expect(subject.url).to eq('clients')
      end
    end
    context 'when GET with resource id' do
      subject { described_class.new(resource, method: :get, id: 12) }

      it 'returns resource url with id' do
        expect(subject.url).to eq('clients/12')
      end
    end
  end

  describe '#parameters' do
    context 'without params specified' do
      it "returns empty hash" do
        expect(subject.parameters).to eq({})
      end
    end
    context 'with params specified' do
      subject { described_class.new(resource, method: :get, params: { name: 'Sam' }) }
      it "returns hash with parameters" do
        expect(subject.parameters).to eq({ params: { name: "Sam" } })
      end
    end 
    context 'when request method is POST' do
      subject { described_class.new(resource, method: :post, params: { name: 'Sam' }) }
      it "returns JSON string with parameters" do
        expect(subject.parameters).to eq({ client: { name: 'Sam' }}.to_json)
      end
    end
    context 'when request method is PUT' do
      subject { described_class.new(resource, method: :put, params: { name: 'Bob' }) }
      it "returns JSON string with parameters" do
        expect(subject.parameters).to eq({ client: { name: 'Bob' }}.to_json)
      end
    end
    context 'when request method is WRONG' do
      subject { described_class.new(resource, method: :wrong, params: { name: 'Bob' }) }
      it "returns empty hash without parameters" do
        expect(subject.parameters).to eq({})
      end
    end      
  end
end