class OccasionsController < ApplicationController
  def show
    @occasion = Occasion.find(params[:id])
    @question = @occasion.question
  end

  def update
    raise
  end
end
