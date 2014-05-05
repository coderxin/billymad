shared_examples "has .all method" do
  it { expect(described_class).to respond_to(:all) }

  describe ".all" do
    it "makes a GET request using the correct resource and id" do
      described_class.should_receive(:validate_attributes_for).with(:all, {})
      Billymad::Request::Proxy.should_receive(:get).with(described_class, { params: {} }).and_return({})
      described_class.all
    end
  end
end