class Product::GoalsController < ApplicationController
  helper_method :current_product

  def index
    @goals = ProductGoal.where(product_id: current_product.id)
  end

  def new
    @goal = ProductGoal.new
  end

  def create
    @goal = ProductGoal.new(product_goal_params.merge(product_id: current_product.id))
    if @goal.save
      render :create
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_goal_params
    params.require(:product_goal).permit(:content)
  end

  def current_product
    @__current_product ||= Product.find(params[:product_id])
  end
end
