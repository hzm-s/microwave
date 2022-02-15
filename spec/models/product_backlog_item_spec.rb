require 'rails_helper'

describe ProductBacklogItem do
  describe 'delegation' do
    it do
      work = Work.new(
        product_id: 123,
        number: 789,
        status: 'preparation',
        description: 'description',
        size: 3,
      )
      item = described_class.new(work: work)

      aggregate_failures do
        expect(item.product_id).to eq work.product_id
        expect(item.number).to eq work.number
        expect(item.status).to eq work.status
        expect(item.description).to eq work.description
        expect(item.size).to eq work.size
      end
    end
  end
end
