class ProductBacklog < ApplicationRecord
  class NoCurrentProductGoal < StandardError; end

  has_one :current_product_goal
  has_many :items, class_name: 'ProductBacklogItem', dependent: :destroy

  delegate :goal, to: :current_product_goal, allow_nil: true

  def set_goal(product_goal_id)
    return false if goal && goal.enable?

    !!self.create_current_product_goal(product_goal_id: product_goal_id)
  end

  def add_item(description)
    raise NoCurrentProductGoal unless goal

    transaction do
      add_work_to_goal!(description)
        .then { add_work_as_item!(_1) }
    end
  end

  private

  def add_work_to_goal!(description)
    goal.build_work(description).tap do
      rollback! unless _1.save
    end
  end

  def add_work_as_item!(work)
    item = self.items.build(work_id: work.id)
    rollback! unless item.save

    work
  end
end
