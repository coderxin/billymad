require "spec_helper"

describe Billymad::Request::Base do
  let(:info) do 
    double(:info, 
      method: :get, 
      resource_name: 'client', 
      plural_resource_name: 'clients',
      url: 'clients',
      parameters: {}
    )
  end

  subject { described_class.new(info) }

  it { should respond_to(:perform) }

  describe '#perform' do
    context 'when data is returned' do
      it 'handles response' do
        response = { client: {} }.to_json
        Billymad::Request::Rest.should_receive(:call).with(:get, 'clients', {}).and_return(response)
        subject.should_receive(:handle_response).with(response)
        expect(subject.perform).to be_nil
      end
    end

    context 'when no data is returned' do
      it 'returns nothing' do
        Billymad::Request::Rest.should_receive(:call).with(:get, 'clients', {}).and_return(nil)
        expect(subject.perform).to be_nil
      end
    end
  end
end