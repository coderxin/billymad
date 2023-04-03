shared_examples 'has .find method' do
  describe '.find' do
    it 'makes a GET request using the correct resource and id' do
      expect(Billymad::Request::Proxy).to receive(:get).with(described_class, { id: 1 }).and_return({})
      described_class.find(1)
    end

    it 'returns nil when nothing has been found' do
      expect(Billymad::Request::Proxy).to receive(:get).with(described_class, { id: 1 }).and_return({})
      expect(described_class.find(1)).to be_nil
    end

    it "returns instance variable of #{described_class}" do
      expect(Billymad::Request::Proxy).to receive(:get).with(described_class,
                                                             { id: 123 }).and_return({ id: '123',
                                                                                       created: "#{Time.now}" })
      expect(described_class.find(123)).to be_instance_of(described_class)
    end
  end
end

