class ProductBacklog < ApplicationRecord
  has_one :current_product_goal

  delegate :goal, to: :current_product_goal, allow_nil: true

  def set_goal(product_goal_id)
    raise ProductGoal::CurrentGoalIsEnable if goal && goal.enable?

    self.create_current_product_goal!(product_goal_id: product_goal_id)
  end
end
