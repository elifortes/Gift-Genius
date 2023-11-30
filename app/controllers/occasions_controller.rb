class OccasionsController < ApplicationController
  def show
    @occasion = Occasion.find(params[:id])
  end
end
