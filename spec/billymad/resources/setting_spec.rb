require "spec_helper"

describe Billymad::Setting do
  include_examples "can be initialized"

  include_examples "has .all method"
  include_examples "has .update methods"
  
  it "has correct .resource_name" do
    expect(described_class.send(:resource_name)).to eq('setting')
  end

  it "has correct .plural_resource_name" do
    expect(described_class.send(:plural_resource_name)).to eq('settings')
  end
end