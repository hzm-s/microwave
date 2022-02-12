require 'rails_helper'

describe ProductGoal do
  let(:product) { create_product(goals: []) }

  describe '.create' do
    it do
      goal = described_class.create(content: 'product goal', achieved: true)
      expect(goal.reload).to_not be_achieved
    end
  end
end
