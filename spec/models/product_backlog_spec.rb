require 'rails_helper'

describe ProductBacklog do
  let(:product) { create_product(goals: %w(1st_goal 2nd_goal)) }

  describe '#set_goal' do
    let(:pbl) { described_class.find_by(product_id: product.id) }
    let(:goal1) { product.goals.first }
    let(:goal2) { product.goals.last }

    it do
      pbl.set_goal(goal1.id)
      expect(pbl.reload.goal).to eq goal1
    end

    it do
      pbl.set_goal(goal1.id)
      expect { pbl.set_goal(goal2.id) }.to raise_error ProductGoal::CurrentGoalIsEnable
    end

    it do
      pbl.set_goal(goal1.id)
      goal1.achieve
      pbl.reload

      pbl.set_goal(goal2.id)

      expect(pbl.reload.goal).to eq goal2
    end
  end
end
