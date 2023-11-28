class GiftsController < ApplicationController
  def create
    @gift = Gift.new(param_strong)
    @myoccasion = Myoccasion.find(params[:myoccasion_id])

    @myoccasion.gift = @gift.id
    @myoccasion.save!
    if @gift.save!
      @myoccasion.gift = @gift.id
      @myoccasion.save!

      redirect_to myoccasion_confirmation_path(@myoccasion)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def param_strong
    params.require(:gift).permit(:title, :description, :price, :price_range)
  end
end
