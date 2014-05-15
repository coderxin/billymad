require "spec_helper"

describe Billymad::Resource::Validations do
  let(:described_class) { Class.new { extend Billymad::Resource::Validations } }

  describe ".mandatory_attributes_for" do
    it "sets mandatory attributes" do
      described_class.mandatory_attributes_for :all, attributes: [ :name, :surname ]
      expect(described_class.send(:mandatory_attributes)).to eq({ all: [:name, :surname] })
    end
  end

  describe ".validate_attributes_for" do
    context "when mandatory attributes are set" do
      it "raises exception with missing attributes" do
        described_class.mandatory_attributes_for :all, attributes: [ :name, :surname ]
        expect {
          described_class.send(:validate_attributes_for, :all, { something: "ABC" })
        }.to raise_error(Billymad::APIError)
      end

      it "is not raising exception with proper attributes" do
        described_class.mandatory_attributes_for :all, attributes: [ :name, :surname ]
        expect {
          described_class.send(:validate_attributes_for, :all, { name: "John", surname: "Doe" })
        }.not_to raise_error
      end
    end

    context "when mandatory attributes are not set" do
      it "no exception is raised" do
        expect {
          described_class.send(:validate_attributes_for, :all, { something: "ABC" })
        }.not_to raise_error(Billymad::APIError)
      end
    end
  end

  describe ".valid?" do
    let(:attributes) {{ name: "Bob", surname: "Johnes" }}

    it "returns true" do
      expect(described_class.send(:valid?, attributes, :name)).to be_true
    end

    it "returns false" do
      expect(described_class.send(:valid?, attributes, :something)).to be_false
    end
  end

  describe ".mandatory_attributes" do
    it "initializes with empty hash" do
      expect(described_class.send(:mandatory_attributes)).to eq({})
    end
  end

  describe ".raise_exception" do
    it "has to raise exception" do
      expect { 
        described_class.send(:raise_exception, :attribute_id) 
      }.to raise_error(Billymad::APIError, "You must specify the mandatory parameter :attribute_id")
    end
  end 
end