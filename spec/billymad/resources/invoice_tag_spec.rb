require 'spec_helper'

describe Billymad::InvoiceTag do
  include_examples 'can be initialized'

  include_examples 'has .all method'
  include_examples 'has .find method'
  include_examples 'has .create method'
  include_examples 'has .destroy methods'

  it 'has correct .resource_name' do
    expect(described_class.send(:resource_name)).to eq('invoice-tag')
  end

  it 'has correct .plural_resource_name' do
    expect(described_class.send(:plural_resource_name)).to eq('invoice-tags')
  end
end

