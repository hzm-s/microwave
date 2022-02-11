require 'rails_helper'

describe '/pbis' do
  let(:product) { create_product }

  describe 'POST' do
    context 'given valid params' do
      it do
        description = 'this is product backlog item'
        post requirements_path, params: {
          product_id: product.id,
          description: description,
        }

        get product_backlog_path(product_id: product.id)

        expect(response.body).to include description
      end
    end
  end
end
