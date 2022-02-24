class Product::GoalsController < ApplicationController
  def index
    @goals = [
      ProductGoal.new(id: 1, content: '1st goal'),
      ProductGoal.new(id: 2, content: '2nd goal'),
      ProductGoal.new(id: 3, content: '3rd goal'),
    ]
  end
end
