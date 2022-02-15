require 'rails_helper'

describe '/product_backlog_items' do
  let(:product) { create_product }

  describe 'POST' do
    context 'given valid params' do
      it do
        description = 'desc_of_1st_pbi'

        post product_backlog_items_path, params: {
          work: {
            product_id: product.id,
            description: description,
          },
        }
        get product_backlog_path(product_id: product.id)

        expect(response.body).to include description
      end
    end
  end
end
