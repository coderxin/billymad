shared_examples "has .create method" do
  it { expect(described_class).to respond_to(:create) }

  describe ".create" do
    let(:attributes) { { first_name: 'Jhonny' } }

    it "makes a POST request using the correct resource and parameters" do
      described_class.should_receive(:validate_attributes_for).with(:create, attributes)
      Billymad::Request::Proxy.should_receive(:post).with(described_class, { params: attributes }).and_return(attributes)
      described_class.create(attributes)
    end
  end
end