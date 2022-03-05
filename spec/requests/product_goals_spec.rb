require 'rails_helper'

describe '/products/:id/goals' do
  let(:product) { create_product }

  describe 'POST' do
    let(:valid) do
      { content: 'the_goal_of_product' }
    end

    context 'given valid params' do
      it do
        post product_goals_path(product_id: product.id), params: { product_goal: valid }

        get product_goals_path(product_id: product.id)
        aggregate_failures do
          expect(response.body).to include valid[:content]
        end
      end
    end

    context 'given invalid params' do
      it do
        post product_goals_path(product_id: product.id), params: { product_goal: valid.merge(content: '') }
        expect(response.body).to include I18n.t('errors.messages.blank')
      end
    end
  end
end
