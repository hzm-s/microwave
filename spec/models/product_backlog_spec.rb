require 'rails_helper'

describe ProductBacklog do
  let!(:product) { create_product(goals: %w(1st_goal 2nd_goal)) }
  let(:pbl) { described_class.find_by(product_id: product.id) }
  let(:goal1) { product.goals.first }
  let(:goal2) { product.goals.last }

  describe 'set goal' do
    it do
      aggregate_failures do
        expect(pbl.set_goal(goal1.id)).to be true
        expect(pbl.reload.goal).to eq goal1
      end
    end

    context 'when goal is already set' do
      before do
        pbl.set_goal(goal1.id)
      end

      it do
        aggregate_failures do
          expect(pbl.set_goal(goal2.id)).to be false
          expect(pbl.reload.goal).to eq goal1
        end
      end

      it do
        goal1.achieve
        pbl.reload

        aggregate_failures do
          expect(pbl.set_goal(goal2.id)).to be true
          expect(pbl.reload.goal).to eq goal2
        end
      end
    end
  end

  describe 'add item' do
    it do
      expect { pbl.add_item('new item') }.to raise_error described_class::NoCurrentProductGoal
    end

    context 'when goal has set' do
      before do
        pbl.set_goal(goal1.id)
      end

      it do
        work = pbl.add_item('new item')
        expect(pbl.reload.items.to_a).to eq [ProductBacklogItem.find_by(work_id: work.id)]
      end
    end
  end
end
