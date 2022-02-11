class CurrentProductGoal < ApplicationRecord
  belongs_to :product, touch: true
  belongs_to :goal, class_name: 'ProductGoal', foreign_key: :product_goal_id
end
