require 'spec_helper'

describe Billymad::Request::Proxy do
  it 'responds to .get' do
    expect(described_class).to respond_to(:get)
  end

  it 'responds to .post' do
    expect(described_class).to respond_to(:post)
  end

  it 'responds to .put' do
    expect(described_class).to respond_to(:put)
  end

  it 'responds to .delete' do
    expect(described_class).to respond_to(:delete)
  end

  let(:resource) { double(:resource) }
  let(:request_info) { double(:info) }
  let(:request_base) { double(:base, perform: {}) }

  describe '.get' do
    it 'builds request info with GET method and performs request' do
      expect(Billymad::Request::Info).to receive(:new).with(resource, method: :get, id: 123).and_return(request_info)
      expect(Billymad::Request::Base).to receive(:new).with(request_info).and_return(request_base)
      described_class.get(resource, id: 123)
    end
  end

  describe '.post' do
    it 'builds request info with POST method and performs request' do
      expect(Billymad::Request::Info).to receive(:new).with(resource, method: :post, id: 123).and_return(request_info)
      expect(Billymad::Request::Base).to receive(:new).with(request_info).and_return(request_base)
      described_class.post(resource, id: 123)
    end
  end

  describe '.put' do
    it 'builds request info with PUT method and performs request' do
      expect(Billymad::Request::Info).to receive(:new).with(resource, method: :put, id: 123).and_return(request_info)
      expect(Billymad::Request::Base).to receive(:new).with(request_info).and_return(request_base)
      described_class.put(resource, id: 123)
    end
  end

  describe '.delete' do
    it 'builds request info with DELETE method and performs request' do
      expect(Billymad::Request::Info).to receive(:new).with(resource, method: :delete, id: 123).and_return(request_info)
      expect(Billymad::Request::Base).to receive(:new).with(request_info).and_return(request_base)
      described_class.delete(resource, 123)
    end
  end
end

