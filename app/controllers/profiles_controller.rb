class ProfilesController < ApplicationController
  def show
    @occasion = Occasion.find(params[:occasion_id])
  end

  def edit
    @occasion = Occasion.find(params[:occasion_id])
    @profile = @occasion.profile
  end

  def update
    @profile = Profile.find(params[:id])
    @occasion = Occasion.find @profile.occasion_id
    @favorite = Favorite.new(param_strong)
    @favorite.occasion = @occasion
    @favorite.user = current_user
    @favorite.save!
    raise
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
