require "spec_helper"

describe Billymad::Resource::Utils do
  let(:described_class) { Class.new { extend Billymad::Resource::Utils } }

  describe "#demodulize" do
    it "extract correct class name from namespaced class" do
      expect(described_class.demodulize("My::ProperClass")).to eq("ProperClass")
    end
  end
end