class GiftsController < ApplicationController
  def create
    @gift = Gift.new(param_strong)
    if @gift.save!
      redirect_to groups_confirmation_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def param_strong
    params.require(:gift).permit(:title, :description, :price, :price_range, :myoccasion_id)
  end
end
