require 'rails_helper'

describe ProductBacklog do
  let(:product) { create_product(goals: %w(1st 2nd)) }
  let(:pbl) { product.backlog }

  describe 'initial' do
    it do
      expect(product.backlog.target).to be_nil
    end
  end

  describe 'set target' do
    context 'when not setted, given unachieved' do
      it do
        goal = product.goals.unachieved.first

        pbl.set_target(goal)

        aggregate_failures do
          expect(pbl.save).to be true
          expect(pbl.target).to eq goal
        end
      end
    end

    context 'when not setted, given achieved' do
      it do
        goal = product.goals.unachieved.first
        goal.achieve!.tap { _1.reload }

        pbl.set_target(goal)

        aggregate_failures do
          expect(pbl.save).to be false
          expect(pbl.product_backlog_target.errors[:unachieved_product_goal]).to include t_model_error(:product_backlog_target, :unachieved_product_goal, :required)
        end
      end
    end
  end
end
