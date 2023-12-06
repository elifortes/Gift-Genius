class ProposalsController < ApplicationController
  def index
    @occasions = current_user.occasions
    @proposals = current_user.occasions.map { |o| o.proposal }
  end

  def show
    @proposal = Proposal.find(params[:id])
    @products = @proposal.products.rank(:row_order)
    @products.sort_by { |product| product.row_order }
    @products.each_with_index { |product, index| product.position = index }

    # check if the user is the owner of the myproposal
    @myoccasion = Myoccasion.find(@proposal.myoccasion_id)
    @orginizer = @myoccasion.user_id
    @user = current_user
    # 17 to 36 consolidating groups #1 choices.
    # when you are an organizer.
    if @orginizer == @user.id
      @worktobedone = true
      products = []
      @pledge = 0
      @myoccasion.occasions.each do |occasion|
        if occasion.answer
          @pledge += occasion.answer.pledge_amount
        end
        if occasion.proposal.products.first
          product = occasion.proposal.products.rank(:row_order).first
          info = { from: User.find(occasion.user.id).personnal.name }
          product.description = User.find(occasion.user.id).personnal.name
          products.push(product)
        end
      end
      @proposal.products.destroy_all
      products.each do |p|
        product = Product.new(title: p.title, description: p.description, url: p.url, position: p.position, selected: p.selected, price: p.price, rating: p.rating)
        product.proposal = @proposal
        product.save!
      end
    end
    @proposal = Proposal.find(params[:id])
    @products = @proposal.products.rank(:row_order)
    @products.sort_by { |product| product.row_order }
    @products.each_with_index { |product, index| product.position = index }
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
    @proposal = Proposal.find(params[:proposal_id])
    @product = Product.find(params[:product_id])
    @myoccasion = Myoccasion.find(@proposal.myoccasion_id)
    @product.selected = true
    @product.save!
    #raise
  end

  private

  def proposal_params
    params.require(:proposal).permit(:title, :description, :myoccasion_id, :occasion_id, :position)
  end
end
