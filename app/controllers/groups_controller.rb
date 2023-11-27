class GroupsController < ApplicationController
  # before_action :authenticate_user!
  def index
    @groups = Group.all
  end


  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create

      @group = Group.new(name: params[:name], user_id: current_user.id)
      if @group.save
        redirect_to groups_path
      else
        render :new
      end
  end

  def edit

  end

  def update
  end


  def destroy
  end
end
