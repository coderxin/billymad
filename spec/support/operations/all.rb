shared_examples 'has .all method' do
  it { expect(described_class).to respond_to(:all) }

  describe '.all' do
    it 'makes a GET request using the correct resource and id' do
      expect(described_class).to receive(:validate_attributes_for).with(:all, {})
      expect(Billymad::Request::Proxy).to receive(:get).with(described_class, { params: {} }).and_return({})
      described_class.all
    end
  end
end

