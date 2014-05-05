require "spec_helper"

describe Billymad::Base do

  it { described_class.should respond_to(:resource_name, :plural_resource_name) }
 
  describe "#set_attributes" do
    let(:resource_object) do 
      object = Billymad::Base.new
      object.set_attributes({ name: "John" })
      object
    end

    it "allows to access attribute" do
      expect(resource_object).to respond_to(:name)
    end

    it "returns set value" do
      expect(resource_object.name).to eq('John')
    end
  end

  describe "#convert_attributes" do
    it "converts #id to Integer" do
      object = Billymad::Base.new({ id: "123" })
      expect(object.id).to be_a(Integer)
    end

    it "converts #created to Time" do
      object = Billymad::Base.new({ created: "2007-12-13T12:12:00+01:00" })
      expect(object.created).to be_a(Time)
    end   
  end

  describe "#prepare_results" do
    context "when empty data set" do
      it "returns empty Array" do
        expect(Billymad::Base.prepare_results([])).to eq([])
      end

      it "returns nothing" do
        expect(Billymad::Base.prepare_results({})).to be_nil
      end
    end

    context "when Array is passed" do
      let(:response_set) do 
        [ { id: 1, something: 'A' }, { id: 2, something: 'B' } ]
      end

      let(:results) { Billymad::Base.prepare_results(response_set) }

      it "returns Array" do
        expect(results).to be_instance_of(Array)
      end

      it "returns Array with things" do
        expect(results).to have(2).things
      end

      it "returns Array with proper objects" do
        expect(results.first).to be_instance_of(Billymad::Base)
      end
    end

    context "when Hash is passed" do
      let(:response_data) { { id: 1, something: 'A' } }

      it "returns resource object" do
        expect(Billymad::Base.prepare_results(response_data)).to be_instance_of(Billymad::Base)
      end
    end
  end

  describe "#demodulize" do
    it "extract correct class name from namespaced class" do
      expect(described_class.demodulize("My::ProperClass")).to eq("ProperClass")
    end
  end
end