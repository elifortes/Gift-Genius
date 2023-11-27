class GroupsController < ApplicationController
  # before_action :authenticate_user!
  def index
    @groups = Group.all
  end


  def show
    @group = Group.find(params[:id])
  end

  def gift
    @group = Group.find(params[:id])
  end

  def confirmation
    @group = Group.find(params[:id])

  end

  def new
    @group = Group.new
  end

  def create

      @group = Group.new(group_params)
      # group_id = params[:group_id]
      # if @group.save
      @occasion= Occasion.new

        redirect_to group_gift_path(params[:group_id])
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
    params.require(:group).permit()
  end
end
