require 'rails_helper'

describe '/products/:id/owner' do
  let(:user) { sign_up }
  let(:product) { register_product }

  before { sign_in(user) }

  describe 'show' do
    it do
      get product_owner_path(product_id: product.id)
      expect(response.body).to include product_owner_path(product_id: product.id)
    end

    it do
      ProductOwner.create!(product: product, user: user)

      get product_owner_path(product_id: product.id)
      expect(response.body).to include user.name
    end

    it do
      other_product = register_product(owner: user)

      get product_owner_path(product_id: product.id)
      expect(response.body).to include I18n.t('product.owners.show.not_owned')
    end
  end

  describe 'create' do
    context 'precondition is satisfied' do
      it do
        post product_owner_path(product_id: product.id, format: :turbo_stream)

        get product_owner_path(product_id: product.id)
        expect(response.body).to include user.name
      end
    end

    context 'precondition is NOT satisfied' do
      it do
        other_product = register_product(owner: user)

        post product_owner_path(product_id: product.id, format: :turbo_stream)
        expect(response.body).to include t_model_error(:product_owner, :base, :already_other_product_owner)
      end
    end
  end
end
