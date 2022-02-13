require 'rails_helper'

describe Work do
  let(:product) { create_product }
  let(:goal) { product.goals.first }

  describe '.create' do
    it do
      work = described_class.create_for_product_goal(goal, description: 'description of work')
      aggregate_failures do
        expect(work.number).to_not be_nil
        expect(work.status.to_sym).to eq :preparation
        expect(work.size).to be_nil
      end
    end
  end

  describe 'number' do
    let(:product_a) { create_product(goals: %w(1st_goal 2nd_goal)) }
    let(:goal_a_1) { product_a.goals.first }
    let(:goal_a_2) { product_a.goals.last }

    let(:product_b) { create_product }
    let(:goal_b) { product_b.goals.first }

    before do
      described_class.create_for_product_goal(goal_b, description: 'product b #1')
      described_class.create_for_product_goal(goal_b, description: 'product b #2')
    end

    it do
      w1 = described_class.create_for_product_goal(goal_a_1, description: 'product a #1')

      w2 = described_class.create_for_product_goal(goal_a_2, description: 'product a #2')
      w2.destroy
      described_class.create_for_product_goal(goal_a_2, description: 'product a #2')

      described_class.create_for_product_goal(goal_b, description: 'product b #3')

      w1.destroy
      described_class.create_for_product_goal(goal_a_1, description: 'product a #3')

      works = described_class.where(product_id: product_a.id).order(:number)

      expect(works.map(&:number)).to eq [2, 3]
    end
  end
end
