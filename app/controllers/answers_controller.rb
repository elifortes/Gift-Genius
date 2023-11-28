class AnswersController < ApplicationController

  def create
    if params[:answers].present?
      params[:answers].each do |question_id, answer_content|
        UserAnswer.create(user: current_user, question_id: question_id, content: answer_content)
      end
      redirect_to groups_path, notice: 'Thank you for completing the questionnaire!'
    else

      redirect_to groups_path, alert: 'No answers were provided.'
    end
  end



end
