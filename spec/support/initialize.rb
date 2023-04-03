shared_examples 'can be initialized' do
  let(:resource_attributes) do
    { first_name: 'John', last_name: 'Doe' }
  end

  let(:resource_object) { described_class.new(resource_attributes) }

  describe '#initialize' do
    it 'sets attributes correctly' do
      expect(resource_object.first_name).to eq(resource_attributes[:first_name])
      expect(resource_object.last_name).to eq(resource_attributes[:last_name])
    end
  end
end
