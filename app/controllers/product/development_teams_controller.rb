class Product::DevelopmentTeamsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    product.teams << current_user.team
  end
end
