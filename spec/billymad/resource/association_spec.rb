require 'spec_helper'

describe Billymad::Resource::Association do
  let(:described_class) { Class.new { include Billymad::Resource::Association } }
  let(:fake_object) { Object.new }
  let(:association_keys) { { 'attribute_id' => 123 } }

  subject do
    allow(BasicObject).to receive(:all).and_return([1, 2, 3])
    allow(BasicObject).to receive(:create).and_return(fake_object)

    described_class.class_eval do
      association :tags, class_name: BasicObject
    end

    object = described_class.new
    allow(object).to receive(:resource_key).and_return('attribute_id')
    allow(object).to receive(:id).and_return(123)
    object
  end

  it 'includes .association method' do
    expect(described_class).to respond_to(:association)
  end

  describe '#association_keys' do
    it 'defines correct association_keys method' do
      expect(subject).to respond_to(:association_keys)
    end

    it 'returns correct association keys hash' do
      expect(subject.association_keys).to eq(association_keys)
    end
  end

  describe '.association' do
    it 'defines correct association method' do
      expect(subject).to respond_to(:tags)
    end

    it 'returns correct collection' do
      expect(subject.tags).to eq([1, 2, 3])
    end

    it 'holds correct target_class' do
      expect(described_class).to receive(:define_association).with(:contacts, BasicObject)
      described_class.association(:contacts, class_name: BasicObject)
    end
  end

  describe '#fetch_associated_data' do
    it 'sends .all to target class' do
      expect(BasicObject).to receive(:all).with(association_keys)
      subject.send(:fetch_associated_data, BasicObject)
    end
  end
end
