class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def move_image
    @proposal = GeneralListing.find(params[:id])
    @product = @proposal.products[params[:old_position].to_i - 1]
    @product.insert_at(params[:new_position].to_i)
    head :ok
    raise
  end

  def update
    @product = Product.update(proposal_params)
    raise
  end

  private

  def params_strong
    params.require(:product).permit(:title, :description, :proposal_id, :position, :url, :selected, :price, :rating)
  end
end
