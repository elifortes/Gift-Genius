class ProductsController < ApplicationController
  def index
    @products = Product.rank(:row_order).all
  end

  def sort
    @product = Product.find(params[:id])
    @product.update(row_order_position: params[:row_order_position])
    raise
    head :no_content
  end

  def list
    @tasks = @list.products.rank(:row_order)
  end

  def move_image
    @proposal = GeneralListing.find(params[:id])
    @product = @proposal.products[params[:old_position].to_i - 1]
    @product.insert_at(params[:new_position].to_i)
    head :ok
    raise
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.update(params_strong)
    raise
  end

  private

  def params_strong
    params.require(:product).permit(:title, :description, :proposal_id, :position, :url, :selected, :price, :rating)
  end
end
