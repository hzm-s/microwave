require 'rails_helper'

describe ProductGoal do
  let(:product) { create_product }
  let(:goal) { product.goals.first }

  describe '.create' do
    it do
      goal = described_class.create(content: 'product goal', achieved: true)
      expect(goal.reload).to_not be_achieved
    end
  end

  describe '#add_work' do
    it do
      work = goal.add_work('desc of work').tap(&:reload)

      aggregate_failures do
        expect(work.product).to eq product
        expect(work).to eq goal.works.first
        expect(work.description).to eq 'desc of work'
      end
    end
  end
end
