require 'rails_helper'

describe '/products' do
  describe 'create' do
    let(:valid) do
      {
        name: 'cool_product',
        vision: 'the_product_vision_of_cool_product',
      }
    end

    context 'given valid params' do
      it do
        post products_path, params: { product: valid }

        get products_path
        aggregate_failures do
          expect(response.body).to include valid[:name]
          expect(response.body).to include valid[:vision]
        end
      end
    end

    context 'given invalid params' do
      it do
        post products_path, params: { product: valid.merge(name: '') }
        expect(response.body).to include I18n.t('errors.messages.blank')
      end
    end
  end
end
