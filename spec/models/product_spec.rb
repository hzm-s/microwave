require 'rails_helper'

describe Product do
  let(:name) { 'product name' }
  let(:vision) { 'product vision' }

  let(:product) { described_class.create!(name: name, vision: vision) }
  let(:goal_content) { 'first goal' }

  describe 'initial' do
    it do
      expect(product.current_goal).to be_nil
    end
  end

  describe '#set_goal' do
    it do
      aggregate_failures do
        expect { product.set_goal(goal_content) }
          .to change(ProductGoal, :count).by(1)
          .and change(CurrentProductGoal, :count).by(1)
          .and change(AchievedProductGoal, :count).by(0)

        expect(product.current_goal).to eq ProductGoal.last
      end
    end

    it do
      product.set_goal(goal_content)

      expect { product.set_goal('second goal') }
        .to raise_error(Product::CurrentGoalNotAchieved)
        .and change(ProductGoal, :count).by(0)
        .and change(CurrentProductGoal, :count).by(0)
    end
  end

  describe '#achieve_current_goal' do
    it do
      product.set_goal(goal_content)

      aggregate_failures do
        expect { product.achieve_current_goal }
          .to change(CurrentProductGoal, :count).by(-1)

        expect(product.reload.current_goal).to be_nil
      end
    end
  end
end
