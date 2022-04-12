require 'rails_helper'

describe Product do
  let(:name) { 'product name' }
  let(:vision) { 'product vision' }
  let(:user) { sign_up }

  describe 'initial' do
    it do
      product = described_class.create(owner: user, name: name, vision: vision)

      aggregate_failures do
        expect(product.owner).to eq user
        expect(product.name.to_s).to eq name
        expect(product.vision.to_s).to eq vision
        expect(product.goals).to be_empty
      end
    end
  end

  describe 'validation' do
    let(:valid) do
      {
        owner: user,
        name: 'product name',
        vision: 'product vision',
      }
    end

    it do
      expect(described_class.new(valid)).to be_valid
    end

    it do
      expect(described_class.new(valid.merge(owner: nil))).to_not be_valid
    end

    it do
      aggregate_failures do
        expect(described_class.new(valid.merge(name: nil))).to_not be_valid
        expect(described_class.new(valid.merge(name: ''))).to_not be_valid
        expect(described_class.new(valid.merge(name: 'a' * 51))).to_not be_valid
      end
    end

    it do
      aggregate_failures do
        expect(described_class.new(valid.merge(vision: nil))).to_not be_valid
        expect(described_class.new(valid.merge(vision: ''))).to_not be_valid
        expect(described_class.new(valid.merge(vision: 'a' * 1001))).to_not be_valid
      end
    end
  end

  describe 'add development team' do
    it do
      product = described_class.create!(owner: user, name: 'the product', vision: 'vision')
      team = create_team
      product.teams << team
      expect { product.teams << team }.to raise_error ActiveRecord::RecordNotUnique
    end
  end
end
