class ProposalsController < ApplicationController

  def index
    @proposals = Proposal.all
  end


  def new

  end

  def show
    @proposal = Proposal.find(params[:id])
  end


  def create
    @proposal = Proposal.new(proposal_params)
    # @proposal.user = current_user

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

end
