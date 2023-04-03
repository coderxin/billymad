shared_examples 'has .create method' do
  it { expect(described_class).to respond_to(:create) }

  describe '.create' do
    let(:attributes) { { first_name: 'Jhonny' } }

    it 'makes a POST request using the correct resource and parameters' do
      expect(described_class).to receive(:validate_attributes_for).with(:create, attributes)
      expect(Billymad::Request::Proxy).to receive(:post).with(described_class,
                                                              { params: attributes }).and_return(attributes)
      described_class.create(attributes)
    end
  end
end

