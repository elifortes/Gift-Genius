class QuestionsController < ApplicationController
  def show
    @occasion = Occasion.find(params[:occasion_id])
    @question = @occasion.question
    @answer = @question.answer
  end

  def edit
    @occasion = Occasion.find(params[:occasion_id])

    @question = @occasion.question
    @movies = ["Drama", "Adventure"]
    @music = ["Pop", "Indie"]
    @books = ["Mystery", "Science Fiction"]
    @hobbies = ["Reading", "Photography", "Hiking"]
    @activities = ["Cooking", "Traveling"]
    @channels = ["Email", "Text Messages"]

    # add new field
  end

  def new
    @occasion = Occasion.find(params[:occasion_id])
    @question = @occasion.question
    raise
  end

  def update
    @question = Question.find(params[:id])
    # check if there is a favorite [occasion.question -> occasion.favorite]
    #       if exist? -> favorite[merge/update]
    # creating a new favorite
    @answer = Answer.new(favorites: params[:question][:favorites], hobbies: params[:question][:hobbies],
                         activities: params[:question][:activities])
    @answer.user = current_user
    @occasion = Occasion.find(@question.occasion_id)
    # update status in occasion questionnaire is done
    @answer.occasion = @occasion
    @occasion.status = true
    @occasion.save!

    if @answer.save!
      redirect_to @occasion, notice: "Questionnaire is saved."
    else
      render :new, alert: :unprocessable_entity
    end
  end

  def questionnaire
    @question = Question.find(params[:id])
    @questions = Question.all
  end

  private

  def param_strong
    params.require(:question).permit(:favorites, :recipient, :myoccasion, :gift, :hobbies)
  end
end
