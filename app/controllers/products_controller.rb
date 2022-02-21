class ProductsController < ApplicationController
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def index
    @products = Product.all
  end

  private

  def product_params
    params.require(:product).permit(:name, :vision)
  end
end
