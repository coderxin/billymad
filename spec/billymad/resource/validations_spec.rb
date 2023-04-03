require 'spec_helper'

describe Billymad::Resource::Validations do
  let(:described_class) { Class.new { extend Billymad::Resource::Validations } }

  describe '.mandatory_attributes_for' do
    it 'sets mandatory attributes' do
      described_class.mandatory_attributes_for :all, attributes: %i[name surname]
      expect(described_class.send(:mandatory_attributes)).to eq({ all: %i[name surname] })
    end
  end

  describe '.validate_attributes_for' do
    context 'when mandatory attributes are set' do
      it 'raises exception with missing attributes' do
        described_class.mandatory_attributes_for :all, attributes: %i[name surname]
        expect do
          described_class.send(:validate_attributes_for, :all, { something: 'ABC' })
        end.to raise_error(Billymad::APIError)
      end
    end
  end

  describe '.valid?' do
    let(:attributes) { { name: 'Bob', surname: 'Johnes' } }

    it 'returns true' do
      expect(described_class.send(:valid?, attributes, :name)).to be_truthy
    end

    it 'returns false' do
      expect(described_class.send(:valid?, attributes, :something)).to be_falsey
    end
  end

  describe '.mandatory_attributes' do
    it 'initializes with empty hash' do
      expect(described_class.send(:mandatory_attributes)).to eq({})
    end
  end

  describe '.raise_exception' do
    it 'has to raise exception' do
      expect do
        described_class.send(:raise_exception, :attribute_id)
      end.to raise_error(Billymad::APIError, 'You must specify the mandatory parameter :attribute_id')
    end
  end
end
