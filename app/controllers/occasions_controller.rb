class OccasionsController < ApplicationController
  def show
    @occasion = Occasion.find(params[:id])
    @gift = Gift.find(@occasion.gift)

    # @myoccasion = Myoccasion.find(params[:id])
    @question = @occasion.question

    # @answer = @occasion.answer # not working
    # print(@answer.hobbies)

    # @answer_id = params[:answer]
    # p @answer_id
    # raise

  end

  def update
    raise
  end
end
