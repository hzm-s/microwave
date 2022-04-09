class Product::DevelopmentTeamsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    product.teams << current_user.team
    redirect_to product_path(product)
  end
end
