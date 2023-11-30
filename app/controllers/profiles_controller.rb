class ProfilesController < ApplicationController
  def show
    @occasion = Occasion.find(params[:occasion_id])
    @profile = @occasion.profile
    @favorite = @profile.favorite
  end

  def edit
    @occasion = Occasion.find(params[:occasion_id])

    @profile = @occasion.profile
    @movies = ["Drama", "Adventure"]

    @music =  ["Pop", "Indie"]
    @books =  ["Mystery", "Science Fiction"]
    @hobbies = ["Reading", "Photography", "Hiking"]
    @activities = ["Cooking", "Traveling"]
    @channels = ["Email", "Text Messages"]

    # add new field
  end

  def new
    @occasion = Occasion.find(params[:occasion_id])
    @profile = @occasion.profile
    raise
  end

  def update
    @profile = Profile.find(params[:id])
    # check if there is a favorite [occasion.profile -> occasion.favorite]
    #       if exist? -> favorite[merge/update]
    # creating a new favorite
    @favorite = Favorite.new(favorites: params[:profile][:favorites], hobbies: params[:profile][:hobbies],
                             activities: params[:profile][:activities])
    @favorite.user = current_user
    @occasion = Occasion.find(@profile.occasion_id)
    # update status in occasion questionnaire is done
    @favorite.occasion = @occasion
    @occasion.status = true
    @occasion.save!

    if @favorite.save!
      redirect_to @occasion, notice: 'Questionnaire is saved.'
    else
      render :new, alert: :unprocessable_entity
    end
  end

  def questionnaire
    @profile = Profile.find(params[:id])
    @questions = Question.all
  end

  def user_answers
    params[:answers].each do |question_id, answer_id|
      UserAnswer.create(user: current_user, question_id:, answer_id:)
    end
  end

  private

  def param_strong
    params.require(:profile).permit(:favorites, :recipient, :myoccasion, :gift, :hobbies)
  end
end
