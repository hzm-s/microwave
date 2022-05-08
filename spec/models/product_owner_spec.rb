require 'rails_helper'

describe ProductOwner do
  let(:user) { sign_up }
  let(:product) { register_product }
  let(:other_product) { register_product }

  describe 'validation' do
    it do
      described_class.create!(product: product, user: user)

      po = described_class.new(product: other_product, user: user)
      po.validate

      expect(po.errors[:base]).to include t_model_error(:product_owner, :base, :already_other_product_owner)
    end
  end

  describe 'query to be able to assume' do
    it do
      expect(described_class.can_assume?(user.id)).to be true
    end

    it do
      described_class.create!(user: user, product: other_product)
      expect(described_class.can_assume?(user.id)).to be false
    end
  end
end
