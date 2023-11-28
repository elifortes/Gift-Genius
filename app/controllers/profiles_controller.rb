class ProfilesController < ApplicationController
  def show
  end

  def questionnaire
    @profile = Profile.find(params[:id])
    @questions = Question.all
  end

    def user_answers
      params[:answers].each do |question_id, answer_id|
        UserAnswer.create(user: current_user, question_id: question_id, answer_id: answer_id)

    end
  end
end
