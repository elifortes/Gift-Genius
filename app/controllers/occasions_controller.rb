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

<<<<<<< HEAD
  def update
    raise
  end
=======

>>>>>>> 7f683b0e3c6d96f7a5fe8980db7bb82253f2641b
end
