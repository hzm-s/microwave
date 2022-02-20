class ProductBacklog < ApplicationRecord
  has_one :product_backlog_target, validate: true

  def set_target(product_goal)
    self.build_product_backlog_target(unachieved_product_goal_id: product_goal.unachieved&.id)
  end

  def target
    product_backlog_target&.goal
  end
end
