require 'rails_helper'

describe ProductGoal do
  let(:product) { create_product }

  describe 'initial' do
    it do
      goal = described_class.new(content: '1st goal')
      expect(goal.content.to_s).to eq '1st goal'
    end
  end

  describe 'validation' do
    let(:valid) do
      { content: 'the product goal' }
    end

    it do
      model = described_class.new(valid)
      expect(model).to be_valid
    end

    it do
      model = described_class.new(valid.merge(content: 'a' * 1001))
      expect(model).to_not be_valid
    end
  end
end
