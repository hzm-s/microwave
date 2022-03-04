class Product::GoalsController < ApplicationController
  def index
    @goals = ProductGoal.where(product_id: current_product.id)
  end

  def create
    ProductGoal.create!(product_goal_params.merge(product_id: current_product.id))
  end

  private

  def product_goal_params
    params.require(:product_goal).permit(:content)
  end

  def current_product
    @__current_product ||= Product.find(params[:product_id])
  end
end
