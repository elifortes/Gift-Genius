class OccasionsController < ApplicationController
  def show
    @occasion = Occasion.find(params[:id])
    @question = @occasion.question
  end
end
