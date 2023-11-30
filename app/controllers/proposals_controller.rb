class ProposalsController < ApplicationController
  def index
    @myoccasions = current_user.myoccasions.includes(:occasions)
    @occassions = current_user.occasions
  end

  def new
  end

  def show
    @proposals = Proposal.find(params[:id])
    @products = @proposals.products
  end

  def move_image
    @proposal = Proposal.find(params[:id])
    @product = @proposal.products[params[:old_position].to_i - 1]
    @product.insert_at(params[:new_position].to_i)
    head :ok
  end

  def update
    raise
    @proposal = GeneralListing.find(params[:id])
    @product = @proposal.products[params[:old_position].to_i - 1]
    @product.insert_at(params[:new_position].to_i)
    head :ok
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.user = current_user

    if @proposal.save
      redirect_to @proposal, notice: "Proposal was successfully created."
    else
      render :new, alert: :unprocessable_entity
    end
  end

  def confirmation
    @proposal = Proposal.find(params[:id])
  end

  private

  def proposal_params
    params.require(:proposal).permit(:title, :description, :myoccasion_id, :occasion_id, :position)
  end

  def filter_proposals_for(user)
    user_answers = user.user_answers.includes(:answer).last(10)
  end
end
