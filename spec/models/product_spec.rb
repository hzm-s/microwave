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
        expect(product.backlog).to_not be_nil
      end
    end
  end
end
