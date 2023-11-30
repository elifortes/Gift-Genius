class OccasionsController < ApplicationController
  def show
    @occasion = Occasion.find(params[:id])
    @favorite =   @occasion.favorite
  end
end
