class OccasionsController < ApplicationController
  def show
    @occasion = Occasion.find(params[:id])
    @answer = @occasion.answer
  end
end
