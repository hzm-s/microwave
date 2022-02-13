require 'rails_helper'

describe ProductGoal do
  let(:product) { create_product }

  describe 'initial' do
    it do
      goal = described_class.create(content: '1st goal', achieved: true)

      aggregate_failures do
        expect(goal.content.to_s).to eq '1st goal'
        expect(goal.reload).to_not be_achieved
      end
    end
  end

  let(:goal) { product.goals.first }

  describe 'add work' do
    it do
      work = goal.add_work('desc of work')

      aggregate_failures do
        expect(work.errors).to be_empty
        expect(work.reload.product).to eq product
        expect(work).to eq goal.works.last
        expect(work.description.to_s).to eq 'desc of work'
      end
    end
  end
end
