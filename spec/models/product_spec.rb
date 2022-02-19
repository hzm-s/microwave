require 'rails_helper'

describe Product do
  let(:name) { 'product name' }
  let(:vision) { 'product vision' }

  describe 'initial' do
    it do
      product = described_class.create(name: name, vision: vision)

      aggregate_failures do
        expect(product.name.to_s).to eq name
        expect(product.vision.to_s).to eq vision
        expect(product.reload.backlog).to_not be_nil
      end
    end
  end

  describe 'validation' do
    let(:valid) do
      {
        name: 'product name',
        vision: 'product vision',
      }
    end

    it do
      model = described_class.new(valid)
      expect(model).to be_valid
    end

    it do
      model = described_class.new(valid.merge(name: 'a' * 51))
      expect(model).to_not be_valid
    end

    it do
      model = described_class.new(valid.merge(vision: 'a' * 1001))
      expect(model).to_not be_valid
    end
  end

  let(:product) { described_class.create!(name: name, vision: vision) }
end
