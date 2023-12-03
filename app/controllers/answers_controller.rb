class AnswersController < ApplicationController
  def new
    @occasion = Occasion.find(params[:occasion_id])
    @question = @occasion.question
     #testing
  end

  def update
    raise
    @occasion = Occasion.find(params[:occasion_id])
    @answer = Answer.new
    @answer.occasion = @occasion
    @answer.user = current_user
    @answer.save!
  end
end
