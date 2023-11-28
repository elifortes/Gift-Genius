class QuestionsController < ApplicationController
  def show
    @questions = Question.all
  end
end
