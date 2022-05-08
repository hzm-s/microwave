class ProductOwner < ApplicationRecord
  belongs_to :product
  belongs_to :user

  delegate :name, :avatar_url, to: :user

  validate do
    if self.class.exists?(user: user)
      errors.add(:base, :already_other_product_owner)
    end
  end

  class << self
    def can_assume?(user_id)
      !exists?(user_id: user_id)
    end
  end
end
