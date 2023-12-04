class ProposalsController < ApplicationController
  def index
    @occasions = current_user.occasions
    @proposals = current_user.occasions.map { |o| o.proposal }
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
end
