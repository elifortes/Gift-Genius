class OccasionsController < ApplicationController
  def show
    @occasion = Occasion.find(params[:id])
    @gift = Gift.find(@occasion.gift)

    # @myoccasion = Myoccasion.find(params[:id])
    @question = @occasion.question




  end


end
