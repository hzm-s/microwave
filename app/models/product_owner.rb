class ProductOwner < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validate do
    if self.class.exists?(user: user)
      errors.add(:user, :already_other_product_owner)
    end
  end
end
