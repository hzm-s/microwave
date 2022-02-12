class ProductGoal < ApplicationRecord
  before_create do
    self.achieved = false
  end
end
