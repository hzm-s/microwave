class ProductBacklogTarget < ApplicationRecord
  belongs_to :product_backlog
  belongs_to :unachieved_product_goal

  delegate :goal, to: :unachieved_product_goal, allow_nil: true
end
