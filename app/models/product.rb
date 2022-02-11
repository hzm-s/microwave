class Product < ApplicationRecord
  class CurrentGoalNotAchieved < StandardError; end

  attribute :name, :name
  attribute :vision, :long_sentence

  has_many :goals, class_name: 'ProductGoal', dependent: :destroy
  has_one :current_product_goal, dependent: :destroy

  def current_goal
    current_product_goal&.goal
  end

  def set_goal(content)
    raise CurrentGoalNotAchieved if current_goal

    self.goals.build(content: content)
      .then { self.create_current_product_goal!(goal: _1) }
  end

  def achieve_current_goal
    self.current_product_goal.destroy!
  end
end
