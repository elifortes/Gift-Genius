class ProductsController < ApplicationController
  def index
    @products = Product.rank(:row_order).all
  end

  def sort
    @product = Product.find(params[:id])
    @product.update(row_order_position: params[:row_order_position])
  end

  def show
    @product = Product.find(params[:id])
    @show_gift = true
    @product = Product.find(params[:proposal_id])
  end

  def update
    @product = Product.update(params_strong)

  end

  private

  def params_strong
    params.require(:product).permit(:title, :description, :proposal_id, :position, :url, :selected, :price, :rating, :row_order)
  end
end
