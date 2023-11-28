class ProposalsController < ApplicationController

  def index
    @proposals = Proposal.all
    @proposals = filter_proposals_for(current_user)
  end


  def new

  end

  def show
    @proposal = Proposal.find(params[:id])
  end


  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.user = current_user

    if @proposal.save
      redirect_to @proposal, notice: 'Proposal was successfully created.'
    else
      render :new
    end
  end

  def confirmation
    @proposal = Proposal.find(params[:id])

  end


    private

  def proposal_params
    params.require(:proposal).permit(:title, :description, :user_id)
  end

  def filter_proposals_for(user)

    user_answers = user.user_answers.includes(:answer).last(10)

  end

end
