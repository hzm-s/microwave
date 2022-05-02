class Product::OwnersController < ApplicationController
  helper_method :current_product

  def show
    @product_owner = ProductOwner.find_by(product_id: current_product.id)
  end

  def create
    product_owner = ProductOwner.new(product: current_product, user: current_user)
    if product_owner.save
      render :create
    else
    end
  end

  private

  def current_product
    @__current_product ||= Product.find_by(id: params[:product_id])
  end
end
