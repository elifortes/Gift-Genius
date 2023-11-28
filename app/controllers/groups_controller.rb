class GroupsController < ApplicationController
  # before_action :authenticate_user!
  def index
    # @groups = Group.all
    @occasions = Occasion.all
  end

  def show
    @occasion = Occasion.find(params[:id])
  end

  def gift
    ## @group = Group.find(params[:id])
  end

  def confirmation
    # @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    # @group = Group.new(group_params)
    # group_id = params[:group_id]
    # if @group.save
    # @occasion = Occasion.new

    redirect_to groups_gift_path
    # else

    # render :new
    # end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit
  end
end
