require 'rails_helper'

describe ProductOwner do
  let(:user) { sign_up }
  let(:product) { register_product }

  describe 'validation' do
    let(:other_product) { register_product }

    it do
      described_class.create!(product: product, user: user)

      po = described_class.new(product: other_product, user: user)
      po.validate

      expect(po.errors[:user]).to include t_model_error(:product_owner, :user, :already_other_product_owner)
    end
  end
end
