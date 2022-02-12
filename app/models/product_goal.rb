class ProductGoal < ApplicationRecord
  class CurrentGoalIsEnable < StandardError; end

  before_create do
    self.achieved = false
  end

  def achieve
    update!(achieved: true)
  end

  def enable?
    achieved == false
  end
end
