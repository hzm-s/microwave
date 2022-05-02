require 'rails_helper'

describe '/products/:id/owner' do
  let(:user) { sign_up }
  let(:product) { register_product }

  before { sign_in(user) }

  describe 'create' do
    it do
      post product_owner_path(product_id: product.id, format: :turbo_stream)

      get product_owner_path(product_id: product.id)
      expect(response.body).to include user.name
    end
  end
end
