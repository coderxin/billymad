require "spec_helper"

describe Billymad::User do
  include_examples "can be initialized"

  include_examples "has .all method"
  include_examples "has .find method"
  
  it "has correct .resource_name" do
    expect(described_class.send(:resource_name)).to eq('user')
  end

  it "has correct .plural_resource_name" do
    expect(described_class.send(:plural_resource_name)).to eq('users')
  end

  describe "#logged_in" do
    it "makes a GET request using the correct resource and id" do
      Billymad::Request::Proxy.should_receive(:get).with(described_class, { id: 'myself' }).and_return({})
      described_class.logged_in
    end
  end  
end