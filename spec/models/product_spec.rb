require 'rails_helper'

describe Product do
  let(:name) { 'product name' }
  let(:vision) { 'product vision' }

  describe '.create' do
    it do
      product = described_class.create(name: name, vision: vision)

      aggregate_failures do
        expect(product.name.to_s).to eq name
        expect(product.vision.to_s).to eq vision
        expect(product.backlog).to be_persisted
      end
    end
  end

  let(:product) { described_class.create(name: name, vision: vision) }

  describe '#add_goal' do
    it do
      product.add_goal('1st goal')
      expect(product.reload.goals.map(&:content)).to eq ['1st goal']
    end
  end
end
