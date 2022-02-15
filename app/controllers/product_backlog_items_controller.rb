class ProductBacklogItemsController < ApplicationController
  def new
    @item = Work.new(product_id: params[:product_id], description: '')
  end

  def create
    product = Product.find(params[:work][:product_id])
    product.backlog.add_item(params[:work][:description])

    redirect_to product_backlog_path(product_id: product.id)
  end
end
