class OccasionsController < ApplicationController
  def show
    @occasion = Occasion.find(params[:id])
    @question = @occasion.question
    @answer = @occasion.answer
    @answer_values = params[:answer_values]
    
    # raise
  end
end
