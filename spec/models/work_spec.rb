require 'rails_helper'

describe Work do
  let(:product) { create_product }
  let(:goal) { product.goals.first }

  describe 'initial' do
    it do
      work = described_class.create(
        product_id: product.id,
        product_goal_id: goal.id,
        description: 'description of work',
      )
      aggregate_failures do
        expect(work.number).to_not be_nil
        expect(work.status.to_sym).to eq :preparation
        expect(work.size).to be_nil
      end
    end
  end

  describe 'numbering' do
    let(:product_a) { create_product(goals: %w(1st_goal 2nd_goal)) }
    let(:goal_a_1) { product_a.goals.first }
    let(:goal_a_2) { product_a.goals.last }

    let(:product_b) { create_product }
    let(:goal_b) { product_b.goals.first }

    before do
      create_work(goal_b, 'product b #1')
      create_work(goal_b, 'product b #2')
    end

    it do
      w1 = create_work(goal_a_1, 'product a #1')

      w2 = create_work(goal_a_2, 'product a #2')
      w2.destroy
      create_work(goal_a_2, 'product a #2')

      create_work(goal_b, 'product b #3')

      w1.destroy
      create_work(goal_a_1, 'product a #3')

      works = described_class.where(product_id: product_a.id).order(:number)

      expect(works.map(&:number)).to eq [2, 3]
    end
  end

  private

  def create_work(goal, description)
    described_class.create(
      product_id: goal.product_id,
      product_goal_id: goal.id,
      description: description,
    )
  end
end
