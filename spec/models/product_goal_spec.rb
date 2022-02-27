require 'rails_helper'

xdescribe ProductGoal do
  let(:product) { create_product }

  describe 'initial' do
    it do
      goal = described_class.create(content: '1st goal', status: 'achieved')

      aggregate_failures do
        expect(goal).to be_persisted
        expect(goal.content.to_s).to eq '1st goal'
        expect(goal).to be_unachieved
        expect(goal.unachieved).to_not be_nil
        expect(goal.achieved).to be_nil
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

  describe 'achieve' do
    let(:goal) { described_class.create!(content: 'the goal') }

    context 'when unachieved' do
      it do
        goal.achieve!.tap { _1.reload }

        aggregate_failures do
          expect(goal).to be_achieved
          expect(goal.unachieved).to be_nil
          expect(goal.achieved).to_not be_nil
        end
      end
    end

    context 'when achieved' do
      it do
        goal.achieve!
        expect { goal.achieve! }.to raise_error described_class::AlreadyAchieved
      end
    end
  end
end
