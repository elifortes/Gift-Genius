class OccasionsController < ApplicationController
  def show
    @occasion = Occasion.find(params[:id])
    @profile = @occasion.profile
  end
end
