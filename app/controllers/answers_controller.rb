class AnswersController < ApplicationController
  def new
    @occasion = Occasion.find(params[:occasion_id])
    @question = @occasion.question
  end

  def update
    # @occasion = Occasion.find(params[:occasion_id])
    # @answer = Answer.new
    # @answer.occasion = @occasion
    # @answer.user = current_user
    # @answer.save!


    @occasion = Occasion.find(params[:occasion_id])
    @answer = Answer.find_or_initialize_by(occasion: @occasion, user: current_user)
    @answer.mark_as_completed
    if @answer.save
      if @occasion.answers.all?(&:completed?)
        @occasion.update(status: true)
      end
    else
      render :new
    end
  end
end
