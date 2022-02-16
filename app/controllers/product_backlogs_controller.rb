class ProductBacklogsController < ApplicationController
  def show
    product = Product.find(params[:product_id])
    @items = product.backlog.items
  end
end
