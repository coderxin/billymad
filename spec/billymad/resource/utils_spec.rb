require 'spec_helper'

describe Billymad::Resource::Utils do
  describe '#demodulize' do
    let(:described_class) { Class.new { include Billymad::Resource::Utils } }

    it 'extract correct class name from namespaced class' do
      expect(described_class.demodulize('My::ProperClass')).to eq('ProperClass')
    end
  end

  describe '#underscore' do
    let(:described_class) { Class.new { extend Billymad::Resource::Utils } }

    it do
      expect(described_class.underscore('text')).to eq('text')
      expect(described_class.underscore('camelCase')).to eq('camel_case')
      expect(described_class.underscore('dash-case')).to eq('dash_case')
    end
  end
end
