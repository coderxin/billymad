require 'spec_helper'

describe String do
  it 'properly converts camelized class name' do
    expect('MySuperResource'.dasherize).to eq('my-super-resource')
  end
end

