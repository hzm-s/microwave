class ProductGoal < ApplicationRecord
  class CurrentGoalIsEnable < StandardError; end

  has_many :works, dependent: :destroy

  before_create do
    self.achieved = false
  end

  def achieve
    update!(achieved: true)
  end

  def add_work(description)
    self.works.create_for_product_goal(self, description: description)
  end

  def enable?
    achieved == false
  end
end
