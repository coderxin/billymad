require "spec_helper"

describe Billymad::Client do
  include_examples "can be initialized"

  include_examples "has .all method"
  include_examples "has .find method"
  include_examples "has .create method"
  include_examples "has .update methods"
  include_examples "has .destroy methods"
  
  it "has correct .resource_name" do
    expect(described_class.send(:resource_name)).to eq('client')
  end

  it "has correct .plural_resource_name" do
    expect(described_class.send(:plural_resource_name)).to eq('clients')
  end

  it "has correct #resource_key" do
    expect(described_class.new.send(:resource_key)).to eq('client_id')
  end

  context "when has ClientTag association" do
    subject { described_class.new(id: 123) }

    it "responds to #tags" do
      expect(subject).to respond_to(:tags)
    end

    it "returns data as Array" do
      Billymad::ClientTag.should_receive(:all).and_return([])
      expect(subject.tags).to eq([])
    end
  end

  it "responds to #contacts" do
    expect(described_class.new).to respond_to(:contacts)
  end

  it "responds to #property_values" do
    expect(described_class.new).to respond_to(:property_values)
  end  

  it "responds to #properties" do
    expect(described_class.new).to respond_to(:properties)
  end      
end