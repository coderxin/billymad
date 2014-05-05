shared_examples "has .update methods" do
  subject { described_class }

  it { should respond_to(:update) }
  it { expect(subject.new).to respond_to(:update) }
  it { expect(subject.new).to respond_to(:reload!) }

  describe ".update" do
    let(:attributes) { { id: 123, first_name: 'Bobby' } }

    it "makes a PUT request using the correct resource and parameters" do
      described_class.should_receive(:validate_attributes_for).with(:update, attributes)
      Billymad::Request::Proxy.should_receive(:put).with(described_class, id: 123, params: { first_name: 'Bobby' }).and_return(attributes)
      described_class.update(attributes)
    end
  end

  context "given resource object" do
    let(:attributes)         { { id: 123, first_name: 'Bobby' } }
    let(:resource_object)    { described_class.new(attributes) }
    let(:changed_attributes) { { last_name: 'Boy' } }
      
    describe "#update" do
      it "makes a PUT request using the correct resource and parameters" do
        described_class.should_receive(:validate_attributes_for).with(:update, changed_attributes)
        Billymad::Request::Proxy.should_receive(:put).with(described_class, id: 123, params: changed_attributes).and_return(attributes.merge(changed_attributes))
        expect(resource_object.update(changed_attributes).attributes).to eq(attributes.merge(changed_attributes))
      end
    end

    describe "#reload!" do
      it "makes a GET request using the correct resource" do
        Billymad::Request::Proxy.should_receive(:get).with(described_class, id: 123).and_return(attributes)
        expect(resource_object.reload!.attributes).to eq(attributes)
      end
    end
  end
end