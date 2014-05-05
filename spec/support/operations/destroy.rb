shared_examples "has .destroy methods" do
  it { expect(described_class).to respond_to(:destroy) }

  describe ".destroy" do
    it "makes a DELETE request using the correct resource and resource id" do
      Billymad::Request::Proxy.should_receive(:delete).with(described_class, 999).and_return(true)
      described_class.destroy(999)
    end
  end

  describe "#destroy" do
    it "makes a DELETE request using the correct resource and resource id" do
      resource_object = described_class.new(id: 100)
      Billymad::Request::Proxy.should_receive(:delete).with(described_class, 100).and_return(true)
      resource_object.destroy
    end
  end
end