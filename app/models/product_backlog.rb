class ProductBacklog < ApplicationRecord
  class NoCurrentProductGoal < StandardError; end

  has_one :current_product_goal
  has_many :items, class_name: 'ProductBacklogItem', dependent: :destroy

  delegate :goal, to: :current_product_goal, allow_nil: true

  def set_goal(product_goal_id)
    raise ProductGoal::CurrentGoalIsEnable if goal && goal.enable?

    self.create_current_product_goal!(product_goal_id: product_goal_id)
  end

  def add_item(description)
    raise NoCurrentProductGoal unless goal

    transaction do
      work = goal.add_work(description)
      rollback! unless self.items.build(work_id: work.id).save
    end
  end
end
