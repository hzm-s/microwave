class Work < ApplicationRecord
  enum :status, { preparation: 0 }

  before_create do
    self.number = self.class.max_number_of_product(product_id) + 1
    self.status = :preparation
  end

  class << self
    def create_for_product_goal(product_goal, attrs)
      attrs.merge(product_id: product_goal.product_id, product_goal_id: product_goal.id)
        .then { create(_1) }
    end

    def max_number_of_product(product_id)
      where(product_id: product_id).maximum(:number).to_i
    end
  end
end
