require 'rails_helper'

xdescribe ProductGoal do
  let(:product) { create_product }

  describe 'initial' do
    it do
      goal = described_class.create(content: '1st goal')

      aggregate_failures do
        expect(goal).to be_persisted
        expect(goal.content.to_s).to eq '1st goal'
      end
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
